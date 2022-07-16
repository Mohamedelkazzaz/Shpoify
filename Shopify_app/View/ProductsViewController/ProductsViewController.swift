//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//
import UIKit
import Floaty
import NVActivityIndicatorView
import Lottie
import ProgressHUD

class ProductsViewController: UIViewController {


    @IBOutlet weak var loadingIndecator: NVActivityIndicatorView!
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
        initproducts()
        FloatyButton()
        Indectore.initIndecatore()

    }
    //MARK: productsData
    func initproducts(){
        let ViewModel = ProductsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { products , error in
            if let products = products{
                self.arrayOfProducts = products
                self.productsCollection.reloadData()
                ProgressHUD.dismiss()
            }
            if let error = error {
                print(error)
            }
        }
    }
    //MARK: FloatyButton
    func FloatyButton(){
        
        floaty.buttonColor = UIColor(named: "secodeColor")!
        floaty.paddingX = 20
        floaty.paddingY = 100
        
        floaty.openAnimationType = .pop
        floaty.buttonImage = UIImage(named: "plus")
        floaty.itemButtonColor = UIColor(named: "secodeColor")!
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
        ProgressHUD.show()
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
    //MARK: SearchButton
    @IBAction func SearchButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: cartButton
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        let check =   ApplicationUserManger.shared.getUserStatus()
        if check == true{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CartsViewController") as? CartsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    //MARK: favoritButton
    @IBAction func favoritButton(_ sender: Any) {
        ApplicationUserManger.shared.checkUserIsLogged { loggedIn in
            if loggedIn {
                let vc = UIStoryboard(name: "Favorites", bundle: .main).instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
              self.navigationController?.pushViewController(vc, animated: true)
            }
        else{
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
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
                ProgressHUD.dismiss()
            }
            if let error = error {
                print(error)
            }
        }
    }
    
}
extension ProductsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (filtered) {
           return arrayFiltered.count
        }
        else{
           return arrayOfProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell!.productImage.layer.borderWidth = 0.1
        cell!.productImage.layer.cornerRadius = 25
        if(filtered){
            cell?.configureCell(productName: arrayFiltered[indexPath.row].title!, productImage: (arrayFiltered[indexPath.row].image?.src!)!, productPrice: arrayFiltered[indexPath.row].variants![0].price ?? "0")
        }
        else{
            cell?.configureCell(productName: arrayOfProducts[indexPath.row].title!, productImage: (arrayOfProducts[indexPath.row].image?.src!)!, productPrice: arrayOfProducts[indexPath.row].variants![0].price ?? "0")
        }


        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let leftAndRightPaddings: CGFloat = 40
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productsCollection.deselectItem(at: indexPath, animated: true)
        let vc = UIStoryboard(name: "ProductDetails", bundle: .main).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        if (filtered) {
            vc.product = arrayFiltered[indexPath.row]
        }
        else {
            vc.product = arrayOfProducts[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



