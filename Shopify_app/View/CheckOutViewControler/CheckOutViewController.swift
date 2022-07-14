//
//  CheckOutViewController.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 06/12/1443 AH.
//

import UIKit

class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var MyOrdersColletion: UICollectionView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var couponText: UITextField!
    @IBOutlet weak var discountLable: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    var totlaprice = ""
    var address = ""
    var arratOOrders = [Favorites]()
    var cart : [Cart] = []
    var viewModel = DiscountViewModel()
    var discounts: [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyOrdersColletion.dataSource = self
        MyOrdersColletion.delegate = self
        do {
            cart = try context.fetch(Cart.fetchRequest())
            
        } catch let error {
            print(error)
        }
        
        //CoreDataManager.shared.fetchDataInCart(appDelegate: appDelegate.self)
        MyOrdersColletion.reloadData()
        
        viewModel.fetchDiscounts()
        viewModel.bindingData = { discount, error in
            DispatchQueue.main.async {
                self.MyOrdersColletion.reloadData()
            }
            
            if let error = error{
                print(error.localizedDescription)
            }
        }
  
    }
    
    @IBAction func applyCoupon(_ sender: UIButton) {
        totalPrice.text = "\(viewModel.applyCoupon(code: couponText.text ?? "", price: Double(totalPrice.text ?? "0") ?? 0))"
    }
    @IBAction func paymentButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        vc.amount = totalPrice.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension CheckOutViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOrderItemCell", for: indexPath) as! MyOrderItemCell
        cell.setupCell(cart: cart[indexPath.row])
        subTotal.text = "\(ApplicationUserManger.shared.getTotalPrice() ?? 0)"
        totalPrice.text = "\(ApplicationUserManger.shared.getTotalPrice() ?? 0)"
        addressLable.text = address
        return cell
    }

 
}
