//
//  RegisterationViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 05/07/2022.
//

import UIKit

class RegisterationViewController: UIViewController {
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    var viewModel = AuthenticationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView ()
    }
    func configreView () {
        createAccountBtn.layer.cornerRadius = 10
    }
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        registerNewUser()
    }
    func registerNewUser() {
        guard let firstName = firstNameTF.text, let lastName = secondNameTF.text, let email = emailTF.text,
              let password = passwordTF.text else {return}
        let customer = Customer(first_name: firstName, last_name: lastName, email: email, phone: nil, tags: password, id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        viewModel.checkUserIsExist(email: email) { emailIsExist in
            if !emailIsExist{
                self.viewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
                    guard error == nil else {return}
                    DispatchQueue.main.async {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        let nav = UINavigationController(rootViewController: vc)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true, completion: nil)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.showAlertError(title: "your email is already exist", message: "can you login!!")
                }
            }
        }
    }
}
