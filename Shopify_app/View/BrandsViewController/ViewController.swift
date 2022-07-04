//
//  ViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var brandsCollection: UICollectionView!
    
    @IBOutlet weak var loadIndecator: UIActivityIndicatorView!
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
        initbrandsView()
        setupTimer()
        loadIndecator.hidesWhenStopped=true
        loadIndecator.startAnimating()
        
    }

    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
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

    //MARK: BrandsData
    func initbrandsView(){
        let ViewModel = BrandsViewModel()
        ViewModel.fetchData()
        ViewModel.updateData = { brands , error in
            if let brands = brands{
                self.arrayOfBrands = brands
                self.brandsCollection.reloadData()
                self.loadIndecator.stopAnimating()
            }
            if let error = error {
                print(error.localizedDescription)
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
            cell.adsImage.layer.borderWidth = 0.5
            cell.adsImage.layer.borderColor = UIColor.gray.cgColor
            cell.adsImage.layer.cornerRadius = 25
            return cell
        }else{
            let cell =  brandsCollection.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as? BrandCell
            
            cell?.configureCell(brandName: arrayOfBrands[indexPath.row].title!, brandImage: (arrayOfBrands[indexPath.row].image?.src)!)
            cell!.brandImage.layer.borderColor = UIColor.gray.cgColor
            cell!.brandImage.layer.borderWidth = 0.5
            cell!.brandImage.layer.cornerRadius = 25
            return cell!
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollectionView {
            return CGSize(width: 285, height: 128)
        }else{
           return CGSize(width: self.view.frame.width*0.44, height: self.view.frame.width*0.6)
           // return CGSize(width: 170, height: 184)
        }
       
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
        vc.brandName = arrayOfBrands[indexPath.row].title!
        navigationController?.pushViewController(vc, animated: true)
        
    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let leftAndRightPaddings: CGFloat = 10
//        let numberOfItemsPerRow: CGFloat = 2.0
//
//        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
//        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
//
//    }

   
    
}


