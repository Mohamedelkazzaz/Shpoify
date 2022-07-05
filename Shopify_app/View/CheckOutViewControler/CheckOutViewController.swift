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
    override func viewDidLoad() {
        super.viewDidLoad()
        MyOrdersColletion.dataSource = self
        MyOrdersColletion.delegate = self
    }
    @IBAction func applyCoupon(_ sender: UIButton) {
    }
    @IBAction func paymentButton(_ sender: Any) {
    }
    


}
extension CheckOutViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOrderItemCell", for: indexPath) as! MyOrderItemCell
        
        
        return cell
    }

 
}
