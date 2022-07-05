//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit

class ProductsListViewController: UIViewController {

    @IBOutlet weak var loadIndecator: UIActivityIndicatorView!
    @IBOutlet weak var priceSliderOut: UISlider!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var priceLable: UILabel!
    
    var arrayOfProducts = [Product]()
    var arrayOfBrandProducts = [Product]()
    var arrayByPrices = [Product]()
    var brandName = ""
    var filtered = false
    var isCommingFromSearch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollection.dataSource = self
        productsCollection.delegate = self
        
        if  brandName != "" {
            initProductsView()

        }else{
            comingFromSearch()
        }
        
        
        loadIndecator.hidesWhenStopped = true
        loadIndecator.startAnimating()
        
        priceLable.isHidden = true
        priceSliderOut.isHidden = true
    }
    
    //MARK: priceSlider
    @IBAction func priceSlider(_ sender: UISlider) {
        filtered = true
        let sortedArray = self.arrayOfBrandProducts.sorted {a,b in
            Float(a.variants?[0].price ?? "") ?? 0 < Float(b.variants?[0].price ?? "") ?? 0
        }
        priceSliderOut.minimumValue = Float(sortedArray[0].variants?[0].price ?? "") ?? 0
        
        let filteredByPrice = self.arrayOfBrandProducts.filter { element in
            priceLable.text = "\(Int(sender.value))"
            return Float(element.variants?[0].price ?? "") ?? 0 <= sender.value
        }
        self.arrayByPrices = filteredByPrice
        self.productsCollection.reloadData()
        
    }
    
    //MARK: filter Button bySlider
    @IBAction func filterButton(_ sender: UIButton) {
        priceLable.isHidden = !priceLable.isHidden
        priceSliderOut.isHidden = !priceSliderOut.isHidden
    }
    
    //MARK: initProductsView
    func initProductsView(){
        let ViewModel = ProductsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfProducts = products
                let filterArray = self.arrayOfProducts.filter { element in
                    return element.vendor == self.brandName
                }
                self.arrayOfBrandProducts = filterArray
                self.productsCollection.reloadData()
                self.loadIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: comingFromSearch
    func comingFromSearch(){
        let ViewModel = ProductsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfBrandProducts = products
                self.productsCollection.reloadData()
                self.loadIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

}
extension ProductsListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (filtered){
            return arrayByPrices.count
        }
        else{
               return arrayOfBrandProducts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell
        
        if (filtered){
            cell?.configureCell(productName: arrayByPrices[indexPath.row].title!, productImage: (arrayByPrices[indexPath.row].image?.src!)!, productPrice: arrayByPrices[indexPath.row].variants![0].price ?? "0")
        }
        else{
            cell?.configureCell(productName: arrayOfBrandProducts[indexPath.row].title!, productImage: (arrayOfBrandProducts[indexPath.row].image?.src!)!, productPrice: arrayOfBrandProducts[indexPath.row].variants![0].price ?? "0")
        }
        
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)

    }
}
