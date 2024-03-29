//
//  ProductDetailsViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import UIKit
import SDWebImage
import ProgressHUD

class ProductDetailsViewController: UIViewController {
    

    let productDetailsViewModel = ProductDetailsViewModel()
    let orderViewModel = OrderViewModel()
    let favoritesViewModel = FavoritesViewModel()
    var isFromBookmarks = false
    var product: Product?
    var isFound = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var passedFav: Favorites?
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var imageControl: UIPageControl!
    @IBOutlet weak var productDetailsCollectionView: UICollectionView!
    @IBOutlet weak var favoritesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        checkProductInFavorites()
    }
    func checkProductInFavorites() {
        guard let productID = product?.id else {return}
        productDetailsViewModel.checkProductsInFavorites(productID: productID) {
            productFoundInFavorites in
            if productFoundInFavorites { self.favoritesBtn.isSelected = true
                self.favoritesBtn.setImage(UIImage(named: "heartfill"), for: .normal)
            }
        }
    }
    
    func initView() {
        collectionViewConfig()
        collectionViewUpdate()
      
    }
    
    func collectionViewConfig() {
        productDetailsCollectionView.dataSource = self
        productDetailsCollectionView.delegate = self
        productDetailsCollectionView.register(UINib(nibName: "ProductDetailsCollectionViewImageCell", bundle: .main), forCellWithReuseIdentifier: "ProductDetailsCollectionViewImageCell")
    }
    
    func collectionViewUpdate() {
        
        guard let product = product, let variant = product.variants,let price = variant[0].price else {return  }
        productPrice.text = "\(ConvertPrice.getPrice(price: Double(price ?? "") ?? 0.0))"
        productTitle.text = product.title
        productDescription.text = product.body_html
    }
    

    
    
    
    @IBAction func addToWishListBtn(_ sender: UIButton) {
        ApplicationUserManger.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.favoritesBtn.setImage(UIImage(named: "heartfill"), for: .normal)
                self.addProductToFavorites()
            }else{
                self.toLogin()
            }
        }
    }
    
    func toLogin(){
        let loginVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
//    func selectedFavoritesBtn(sender: UIButton){
//      //  sender.isSelected = !sender.isSelected
//        if sender.isSelected{
////            self.favoritesBtn.setImage(UIImage(named: "heartfill"), for: .normal)
////            addProductToFavorites()
//        }
////        else{
////            //self.favoritesBtn.setImage(UIImage(named: "heart"), for: .normal)
////           // unselectingProducts()
////        }
//    }
//
////    func unselectingProducts(){
////        guard let productId = product?.id else {return}
////        productDetailsViewModel.deletefromFavorites(productID: productId)
////    }
    
    func addProductToFavorites()    {
        
        guard let product = product, let id = product.id, let variants = product.variants, let customerID = ApplicationUserManger.shared.getUserID() else {return}
        favoritesViewModel.addItemsToFavorite(product: product)
       // CoreDataManager.shared.addToFavorites(id: Int64(customerID), pid: Int64(id), name: product.title!, pimage: (product.image?.src)!, Price: variants[0].price!)
    }
    
  
    
    @IBAction func addToCart(_ sender: Any) {
        ApplicationUserManger.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.addProductToCard()
            }else{
                self.toLogin()
            }
        }
    }
    
    func addProductToCard() {
        for i in CoreDataManager.shared.fetchDataFromCart(){
            if i.id == (product?.id)!{
                isFound = true
            }
        }
        if isFound == true{
            ProgressHUD.colorAnimation = .systemRed
            ProgressHUD.showFailed("Already in cart", interaction: true)
        }else{
            guard let product = product, let id = product.id, let variants = product.variants, let customerID = ApplicationUserManger.shared.getUserID() else {return}
            
            CoreDataManager.shared.addToCart(appDelegate: appDelegate, id: Int64(id), userId: Int64(customerID), title: product.title!, image: (product.image?.src)!, price: variants[0].price!, quantity: 1)
            ProgressHUD.colorAnimation = .systemGreen
            ProgressHUD.show("Add to cart", icon: .cart)
        }
        
    }
    
   
 }





extension ProductDetailsViewController: UICollectionViewDelegate {
    
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFromBookmarks {
            guard let product = passedFav,  let images = product.productImage else {
                return 0 }
            imageControl.numberOfPages = 4
            return images.count
        } else {
        guard let product = product,    let images = product.images else {
            return 0 }
        imageControl.numberOfPages = images.count
        return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewImageCell", for: indexPath) as! ProductDetailsCollectionViewImageCell
     //   guard let product = product, let images = product.images else { return  UICollectionViewCell()  }
      //  cell.productDetailsImage.downloaded(from: product[indexPath.row].images)
        let imageSource = product?.images?[indexPath.row].src ?? ""
        cell.productDetailsImage.sd_setImage(with: URL(string: imageSource), completed: nil)
        cell.productDetailsImage.layer.masksToBounds = true
       cell.productDetailsImage.layer.cornerRadius = 15 //cell.productDetailsImage.frame.height/2
        cell.productDetailsImage.clipsToBounds = true
        if isFromBookmarks {
            let image = passedFav?.productImage ?? ""
            cell.productDetailsImage.sd_setImage(with: URL(string: image), completed: nil)
        } else {
            let imageSource = product?.images?[indexPath.row].src ?? ""
            cell.productDetailsImage.sd_setImage(with: URL(string: imageSource), completed: nil)
        }
        return cell
    }
    
    
//    let ImageSrc = product.images[indexPath.row].src
//    image.productImageView.sd_setImage(with: URL(string: ImageSrc), completed: nil)
//    image.imageHeight.constant = collectionView.frame.height
//    image.imageWidth.constant = collectionView.frame.width
//
//    image.imageCounterLabel.text = "\(indexPath.row + 1)/\(product.images.count)"
//    image.imageCounterLabel.layer.masksToBounds = true
//    image.imageCounterLabel.layer.cornerRadius = image.imageCounterLabel.frame.height / 2
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
