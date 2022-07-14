//
//  ProductsViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//
import UIKit
import NVActivityIndicatorView
class ProductsListViewController: UIViewController {

    @IBOutlet weak var noDataImage: UIImageView!
    
    @IBOutlet weak var searchBare: UISearchBar!
    @IBOutlet weak var loadingIndecator: NVActivityIndicatorView!
    @IBOutlet weak var priceSliderOut: UISlider!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var priceLable: UILabel!
    
    var arrayOfProducts = [Product]()
    var arrayOfFilterdProducts = [Product]()
    var arrayByPrices = [Product]()
    var brandName = ""
    var filtered = false
    var searchFiltered = false
    var isCommingFromSearch = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollection.dataSource = self
        productsCollection.delegate = self
        searchBare.delegate = self
        noDataImage.isHidden = true
        
        if  brandName != "" {
            initProductsView()
            print("from brand")

        }else{
            print("from search")
            comingFromSearch()
        }
        
        Indectore.createIndecatore(loadingIndecator: loadingIndecator)
        priceLable.isHidden = true
        priceSliderOut.isHidden = true
    }
    
    //MARK: priceSlider
    @IBAction func priceSlider(_ sender: UISlider) {
        filtered = true
        let sortedArray = self.arrayOfFilterdProducts.sorted {a,b in
            Float(a.variants?[0].price ?? "") ?? 0 < Float(b.variants?[0].price ?? "") ?? 0
        }
        priceSliderOut.minimumValue = Float(sortedArray[0].variants?[0].price ?? "") ?? 0
        priceSliderOut.maximumValue = Float(sortedArray[sortedArray.count-1].variants?[0].price ?? "") ?? 0
        let filteredByPrice = self.arrayOfFilterdProducts.filter { element in
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
                self.arrayOfFilterdProducts = filterArray
                self.productsCollection.reloadData()
                self.loadingIndecator.stopAnimating()
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
                self.arrayOfFilterdProducts = products
                self.productsCollection.reloadData()
                self.loadingIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: artButton
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        let check =   ApplicationUserManger.shared.getUserStatus()
        if check == true{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartsViewController") as! CartsViewController
            //let vc = storyboard?.instantiateViewController(withIdentifier: "CartsViewController") as? CartsViewController
            self.navigationController?.pushViewController(vc, animated: true)
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
}
//MARK: collectionView
extension ProductsListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if (filtered){
            return arrayByPrices.count
        }
        
        else{
               return arrayOfFilterdProducts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell
        
        cell!.layer.cornerRadius = 25
        cell?.productImage.layer.cornerRadius = 25
        
        if (filtered){
            cell?.configureCell(productName: arrayByPrices[indexPath.row].title!, productImage: (arrayByPrices[indexPath.row].image?.src!)!, productPrice: arrayByPrices[indexPath.row].variants![0].price ?? "0")
        }
        else{
            cell?.configureCell(productName: arrayOfFilterdProducts[indexPath.row].title!, productImage: (arrayOfFilterdProducts[indexPath.row].image?.src!)!, productPrice: arrayOfFilterdProducts[indexPath.row].variants![0].price ?? "0")
        }

        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let leftAndRightPaddings: CGFloat = 30
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productsCollection.deselectItem(at: indexPath, animated: true)
        let product = arrayOfFilterdProducts[indexPath.row]
        let vc = UIStoryboard(name: "ProductDetails", bundle: .main).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: searchbar
extension ProductsListViewController:UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filtered = true
        arrayByPrices = arrayOfFilterdProducts
         DispatchQueue.main.async {
        self.productsCollection.reloadData()
         }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filtered = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrayByPrices = []
        if searchText == ""{
            arrayByPrices = arrayOfFilterdProducts
            self.noDataImage.isHidden = true
            self.productsCollection.isHidden = false
            self.productsCollection.reloadData()
        }else{
            for product in arrayOfFilterdProducts{
                guard let title = product.title else{return}
                if title.hasPrefix(searchText) || title.hasPrefix(searchText.uppercased()){
                    arrayByPrices.append(product)
                    self.noDataImage.isHidden = true
                    self.productsCollection.isHidden = false
                    self.productsCollection.reloadData()
                }else{
                    if (arrayByPrices.count != 0){
                       
                    }
                    else{
                        self.noDataImage.isHidden = false
                        self.productsCollection.isHidden = true
                        self.productsCollection.reloadData()
                    }
                   
                }
            }
        }
      //  DispatchQueue.main.async {
            self.productsCollection.reloadData()
       // }
    }
}

