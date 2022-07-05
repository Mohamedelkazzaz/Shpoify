//
//  LoginViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 05/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logintButton: UIButton!
    @IBOutlet weak var createNewAccountButton: UIButton!
    var viewModel = AuthenticationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView ()
    }
    func configreView () {
        logintButton.layer.cornerRadius = 10
    }
    @IBAction func tapLoginButton(_ sender: UIButton) {
        loginUser()
    }
    @IBAction func tapToCreateAccountButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "RegisterationViewController") as! RegisterationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func loginUser(){
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        viewModel.checkUserIsLogged(email: email, password: password) { [self] customerLogged in
            if customerLogged != nil {
                DispatchQueue.main.async {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
                }
            }else{
                ApplicationUserManger.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
            }
        }
    }
}
