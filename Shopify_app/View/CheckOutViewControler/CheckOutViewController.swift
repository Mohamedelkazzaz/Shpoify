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
                print(error)
            }
        }
  
    }
    
    @IBAction func applyCoupon(_ sender: UIButton) {
        let price = viewModel.applyCoupon(code: couponText.text ?? "", price: ApplicationUserManger.shared.getTotalPrice() ?? 0.0)
        totalPrice.text = "\(round(price * 100) / 100)"
        print("lin58 in chout \(round(price * 100) / 100)")
        ApplicationUserManger.shared.setTotalPrice(totalPrice: Double(totalPrice.text ?? "") ?? 0.0)
    }
    @IBAction func paymentButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        vc.amount = ApplicationUserManger.shared.getTotalPrice()!
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
        
        
        let subtotal = ApplicationUserManger.shared.getTotalPrice() ?? 0
        subTotal.text = "\(ConvertPrice.getPrice(price: subtotal ))"
        
        let totalprice = ApplicationUserManger.shared.getTotalPrice()
        totalPrice.text = "\(ConvertPrice.getPrice(price: totalprice ?? 0.0 ))"
        addressLable.text = address

        let price = cart[indexPath.row].price
        let convertPrice = ConvertPrice.getPrice(price: Double(price ?? "") ?? 0.0)
        cell.priceLable.text = "\(convertPrice)"

        return cell
    }

 
}
