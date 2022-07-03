//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit
import Floaty

class ProductsViewController: UIViewController {


    @IBOutlet weak var SegmentControle: UISegmentedControl!
    @IBOutlet weak var productsCollection: UICollectionView!
    var arrayOfProducts = [Product]()
    var arrayFiltered =  [Product]()
    let floaty = Floaty()
    var collectionId = ""
    var filtered = false

    @IBOutlet weak var productsCollection: UICollectionView!
    var arrayOfProducts = [Product]()
    let floaty = Floaty()

    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollection.dataSource = self
        productsCollection.delegate = self
        productsData()
        FloatyButton()
    }
    //MARK: productsData
    func productsData(){
        let ViewModel = ProductsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfProducts = products
                self.productsCollection.reloadData()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func FloatyButton(){
        floaty.buttonColor = .orange
        floaty.paddingX = 20
        floaty.paddingY = 100
        
        floaty.openAnimationType = .pop
        floaty.buttonImage = UIImage(named: "plus")
        floaty.itemButtonColor = .orange
        floaty.itemTitleColor = .white

        floaty.addItem("T-Shirts", icon: UIImage(named: "tshirt")) { _ in
            let filterArray = self.arrayOfProducts.filter { element in
                return element.product_type == "T-SHIRTS"
            }
            self.arrayFiltered = filterArray
            self.filtered = true
            self.productsCollection.reloadData()
        }
        floaty.addItem("Shoes", icon: UIImage(named: "shoes")){ _ in
            let filterArray = self.arrayOfProducts.filter { element in
                return element.product_type == "SHOES"
            }
            self.arrayFiltered = filterArray
            self.filtered = true
            self.productsCollection.reloadData()
        }
        floaty.addItem("Accessories", icon: UIImage(named: "Accessories")){ _ in
            let filterArray = self.arrayOfProducts.filter { element in
                return element.product_type == "ACCESSORIES"
            }
            self.arrayFiltered = filterArray
            self.filtered = true
            self.productsCollection.reloadData()
        }
        view.addSubview(floaty)
    }
    
    @IBAction func subCategories(_ sender: Any) {
        self.arrayFiltered = []
        filtered=false
        switch SegmentControle.selectedSegmentIndex
        {
            case 0:
                collectionId = "409147506902"
                displayProductsByCategories(collectionId: collectionId)
                
            case 1:
                collectionId = "409129779414"
                displayProductsByCategories(collectionId: collectionId)
            case 2:
                collectionId = "409147539670"
                displayProductsByCategories(collectionId: collectionId)
            case 3:
                collectionId = "409147474134"
                displayProductsByCategories(collectionId: collectionId)
            default:
                break
        }
    }
    //MARK: displayProductsByCategories
    func displayProductsByCategories(collectionId:String){
        
        let ViewModel = ProductsByCategoriesViewModel()
        ViewModel.fetchData(collectionId: collectionId)
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfProducts = products
                self.productsCollection.reloadData()
                print("\(collectionId ) \(self.arrayOfProducts.count)")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    

        floaty.addItem("T-Shirts", icon: UIImage(named: "shirt")) { _ in
        }
        floaty.addItem("Shoes", icon: UIImage(named: "shoes")){ _ in
        }
        floaty.addItem("Accessories", icon: UIImage(named: "acc")){ _ in

        }
        view.addSubview(floaty)
    }

}
extension ProductsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (filtered) {
            print(arrayFiltered.count)
           return arrayFiltered.count
        }
        else{
           return arrayOfProducts.count
        }

        arrayOfProducts.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell

        if(filtered){
            cell?.configureCell(productName: arrayFiltered[indexPath.row].title!, productImage: (arrayFiltered[indexPath.row].image?.src!)!, productPrice: arrayFiltered[indexPath.row].variants![0].price ?? "0")
        }
        else{
            cell?.configureCell(productName: arrayOfProducts[indexPath.row].title!, productImage: (arrayOfProducts[indexPath.row].image?.src!)!, productPrice: arrayOfProducts[indexPath.row].variants![0].price ?? "0")
        }

        cell?.configureCell(productName: arrayOfProducts[indexPath.row].title!, productImage: (arrayOfProducts[indexPath.row].image?.src!)!, productPrice: arrayOfProducts[indexPath.row].variants![0].price ?? "0")

        
        return cell!
    }
    
}
