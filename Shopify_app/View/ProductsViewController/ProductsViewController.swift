//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit
import Floaty

class ProductsViewController: UIViewController {

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
        arrayOfProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.configureCell(productName: arrayOfProducts[indexPath.row].title!, productImage: (arrayOfProducts[indexPath.row].image?.src!)!, productPrice: arrayOfProducts[indexPath.row].variants![0].price ?? "0")
        
        return cell!
    }
    
}
