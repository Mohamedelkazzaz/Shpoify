//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit
import Floaty

class ProductsViewController: UIViewController {


    
    @IBOutlet weak var loadIndecator: UIActivityIndicatorView!
    @IBOutlet weak var SegmentControle: UISegmentedControl!
    @IBOutlet weak var productsCollection: UICollectionView!
    var arrayOfProducts = [Product]()
    var arrayFiltered =  [Product]()
    let floaty = Floaty()
    var collectionId = ""
    var filtered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollection.dataSource = self
        productsCollection.delegate = self
        productsData()
        FloatyButton()
        loadIndecator.hidesWhenStopped=true
        loadIndecator.startAnimating()

    }

    //MARK: productsData
    func productsData(){
        let ViewModel = ProductsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfProducts = products
                self.productsCollection.reloadData()
                self.loadIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: FloatyButton
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
    
    //MARK: subCategories
    @IBAction func subCategories(_ sender: Any) {
        loadIndecator.startAnimating()
        self.arrayFiltered = []
        filtered=false
        switch SegmentControle.selectedSegmentIndex
        {
            case 0:
                collectionId = "409147506902"
                displayProductsByCategories(collectionId: collectionId)
                
            case 1:
                collectionId = "409147474134"
                displayProductsByCategories(collectionId: collectionId)
            case 2:
                collectionId = "409147539670"
                displayProductsByCategories(collectionId: collectionId)
            case 3:
                collectionId =  "409129779414"
                displayProductsByCategories(collectionId: collectionId)
            default:
                break
        }
    }
    
    @IBAction func SearchButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        let check =   ApplicationUserManger.shared.getUserStatus()
        if check == true{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CartsViewController") as? CartsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func favoritButton(_ sender: Any) {
        let check =   ApplicationUserManger.shared.getUserStatus()
        if check == true{
            
        }
        else{
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
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
                self.loadIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
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
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell

        if(filtered){
            cell?.configureCell(productName: arrayFiltered[indexPath.row].title!, productImage: (arrayFiltered[indexPath.row].image?.src!)!, productPrice: arrayFiltered[indexPath.row].variants![0].price ?? "0")
        }
        else{
            cell?.configureCell(productName: arrayOfProducts[indexPath.row].title!, productImage: (arrayOfProducts[indexPath.row].image?.src!)!, productPrice: arrayOfProducts[indexPath.row].variants![0].price ?? "0")
        }


        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)

    }
}



import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        //MARK: Generic Register cells
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderFooter<Cell: UICollectionReusableView>(cellClass: Cell.Type, kind: String){
        //MARK: Generic Register Header (Header/Footer)
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: Cell.self))
    }
    
    //    UICollectionView.elementKindSectionHeader
    
    func dequeueHeaderFooter<Cell: UICollectionReusableView>(kind: String, indexPath:IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }

    
}
