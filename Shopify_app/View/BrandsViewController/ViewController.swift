//
//  ViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//
import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var brandsCollection: UICollectionView!
    
    @IBOutlet weak var loadingIndecator: NVActivityIndicatorView!
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var arrayOfBrands = [Smart_collections]()
    var arrayOfAds: [String] = ["ads1", "ads2", "ads3", "ads4"]
    var timer: Timer?
    var currentAdsIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        brandsCollection.dataSource = self
        brandsCollection.delegate = self
        adsCollectionView.register(UINib(nibName: "adsCell", bundle: nil), forCellWithReuseIdentifier: "adsCell")
        adsCollectionView.delegate = self
        adsCollectionView.dataSource = self
        
        Indectore.createIndecatore(loadingIndecator: loadingIndecator)
        initbrandsView()
        setupTimer()

    }

    //MARK: searchButton
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
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
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    }
    
    func setupTimer(){
        pageControl.numberOfPages = arrayOfAds.count
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToIndexAds), userInfo: nil, repeats: true)
    }
    
    @objc func moveToIndexAds(){
        if currentAdsIndex < arrayOfAds.count - 1 {
            currentAdsIndex += 1
        }else{
            currentAdsIndex = 0
        }
        
        adsCollectionView.scrollToItem(at: IndexPath(row: currentAdsIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentAdsIndex
    }

    //MARK: initBrandsView
    func initbrandsView(){
        let ViewModel = BrandsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { brands , error in
            if let brands = brands{
                self.arrayOfBrands = brands
                self.brandsCollection.reloadData()
                self.loadingIndecator.stopAnimating()
            }
            if let error = error {
                print(error)
            }
        }
    }
    
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView {
            return arrayOfAds.count
        }else{
            return arrayOfBrands.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollectionView{
            let cell = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! adsCell
            cell.adsImage.image = UIImage(named: arrayOfAds[indexPath.row])
            cell.layer.borderWidth = 0.1
            cell.layer.cornerRadius = 25
            return cell
        }else{
            
            let cell =  brandsCollection.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as? BrandCell
            cell?.configureCell(brandName: arrayOfBrands[indexPath.row].title!, brandImage: (arrayOfBrands[indexPath.row].image?.src)!)
            cell!.layer.borderWidth = 0.1
            cell!.layer.cornerRadius = 25
            return cell!
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollectionView {
            return CGSize(width: self.view.frame.width-20, height: 180)
            
        }else{
            let leftAndRightPaddings: CGFloat = 50
            let numberOfItemsPerRow: CGFloat = 2.0
            
            let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
            return CGSize(width: width, height: width*0.7)

        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == adsCollectionView {
           
        }else{
            let vc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
            vc.brandName = arrayOfBrands[indexPath.row].title!
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }

}

