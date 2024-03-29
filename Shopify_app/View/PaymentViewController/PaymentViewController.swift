//
//  PaymentViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 08/07/2022.
//

import UIKit
import Braintree
import BraintreeDropIn
import ProgressHUD

class PaymentViewController: UIViewController {
    @IBOutlet weak var paypalSelectedBtn: UIButton!
    @IBOutlet weak var cashSelectedBtn: UIButton!
    
//    var checkoutDelegate:PaymentCheckoutDelegation?
    
    let authorization = "sandbox_fwfrj4cq_hspcfyx6tzdmdvb9"
    var braintreeAPIClient:BTAPIClient!
    var amount = 0.0
    var ViewModel = OrderViewModel()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let price = ConvertPrice.convertPrice(price: 500.0)
        print(amount)
        if amount >= price{
            cashSelectedBtn.isHidden = true
        }else{
            print("Done")
        }
        
    }
   
    @IBAction func paypalButton(_ sender: UIButton) {
        setOptionSelection(_isPayPaySelected: true)
    }
    
    @IBAction func cashBtn(_ sender: Any) {
        setOptionSelection(_isPayPaySelected: false)
    }
    
//    func paypalSelect(){
//        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
//        payPalDriver.viewControllerPresentingDelegate = self
////        payPalDriver.appSwitchDelegate = self // Optional
//
//        // Specify the transaction amount here. "2.32" is used in this example.
//        let request = BTPayPalRequest(amount: "2.32")
//        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
//
//        payPalDriver.requestOneTimePayment(request as! BTPayPalCheckoutRequest) { (tokenizedPayPalAccount, error) in
//            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
//                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
//
//                // Access additional information
//                let email = tokenizedPayPalAccount.email
//                debugPrint(email)
//                let firstName = tokenizedPayPalAccount.firstName
//                let lastName = tokenizedPayPalAccount.lastName
//                let phone = tokenizedPayPalAccount.phone
//
//                // See BTPostalAddress.h for details
//                let billingAddress = tokenizedPayPalAccount.billingAddress
//                let shippingAddress = tokenizedPayPalAccount.shippingAddress
//            } else if let error = error {
//                // Handle error here...
//                print(error)
//            } else {
//                // Buyer canceled payment approval
//            }
//        }
//    }
    func startCheckout(amount: Double) {
        self.braintreeAPIClient = BTAPIClient(authorization: authorization)
        let payPalDriver = BTPayPalDriver(apiClient: braintreeAPIClient!)
        let request = BTPayPalCheckoutRequest(amount: "\(amount)")
        if ApplicationUserManger.shared.getSelectedCurrency(){
            request.currencyCode = "USD"
        }else{
            request.currencyCode = "EGP"
        }
        var err:Error?
        payPalDriver.tokenizePayPalAccount(with: request) { [weak self] (tokenizedPayPalAccount, error) in
            if tokenizedPayPalAccount != nil {
            } else if let error = error {
                err = error
                print("error is \(error)")
            }
            if err == nil{
                let orders = CoreDataManager.shared.fetchDataFromCart()
                self!.ViewModel.postOrdersToApi(cartArray: orders)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DoneViewController") as! DoneViewController
                vc.modalPresentationStyle = .fullScreen
                self!.present(vc, animated: true)
            }
        }
    }

    @IBAction func checkoutButton(_ sender: Any) {
        if paypalSelectedBtn.isSelected{
            startCheckout(amount: amount)

        }else if cashSelectedBtn.isSelected{
            
            let orders = try! context.fetch(Cart.fetchRequest())//CoreDataManager.shared.fetchDataFromCart()
            ViewModel.postOrdersToApi(cartArray: orders)
            let vc = storyboard?.instantiateViewController(withIdentifier: "DoneViewController") as! DoneViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
//            navigationController?.setNavigationBarHidden(true, animated: true)
        }else{
            ProgressHUD.showFailed("Please choose your payment choise", interaction: true)
        }
    }
    
    func setOptionSelection(_isPayPaySelected :Bool){
        if _isPayPaySelected{
            
            self.paypalSelectedBtn.isSelected = true
            self.cashSelectedBtn.isSelected = false
            self.paypalSelectedBtn.setImage(UIImage(named: "radioon"), for: .normal)
            self.cashSelectedBtn.setImage(UIImage(named: "radiooff"), for: .normal)
        }else{
            self.paypalSelectedBtn.isSelected = false
            self.cashSelectedBtn.isSelected = true
            self.cashSelectedBtn.setImage(UIImage(named: "radioon"), for: .normal)
            self.paypalSelectedBtn.setImage(UIImage(named: "radiooff"), for: .normal)
           
        }
    }
}

extension PaymentViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}


