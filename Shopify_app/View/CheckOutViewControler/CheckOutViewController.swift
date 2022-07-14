//
//  CheckOutViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 06/12/1443 AH.
//

import UIKit

class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var MyOrdersColletion: UICollectionView!
    
    @IBOutlet weak var couponText: UITextField!
    @IBOutlet weak var discountLable: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    var arratOOrders = [Favorites]()
    let favoritesViewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        MyOrdersColletion.dataSource = self
        MyOrdersColletion.delegate = self
    }
    @IBAction func applyCoupon(_ sender: UIButton) {
    }
    @IBAction func paymentButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initOrdesData() {

    }
    


}
extension CheckOutViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOrderItemCell", for: indexPath) as! MyOrderItemCell
        let price = arratOOrders[indexPath.row].productPrice
        let convertPrice = ConvertPrice.getPrice(price: Double(price ?? "") ?? 0.0)
        cell.priceLable.text = "\(convertPrice)"
        return cell
    }

 
}
