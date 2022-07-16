//
//  LoginViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 05/07/2022.
//

import UIKit
import NVActivityIndicatorView
import ProgressHUD
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logintButton: UIButton!
    @IBOutlet weak var createNewAccountButton: UIButton!
    @IBOutlet weak var loadingIndecator: NVActivityIndicatorView!
    var viewModel = AuthenticationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView ()
        ProgressHUD.animationType = .circleRotateChase
        
        
       // Indectore.createIndecatore(loadingIndecator: loadingIndecator)
       // loadingIndecator.stopAnimating()
    }
    func configreView () {
        logintButton.layer.cornerRadius = 10
    }
    @IBAction func tapLoginButton(_ sender: UIButton) {
       // loadingIndecator.padding = 190
      //  loadingIndecator.startAnimating()
        ProgressHUD.show()
        loginUser()
    }
    @IBAction func tapToCreateAccountButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "RegisterationViewController") as! RegisterationViewController
        self.present(vc, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
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
                    ProgressHUD.dismiss()
                   // loadingIndecator.stopAnimating()
                }
            }else{
                ProgressHUD.dismiss()
                ApplicationUserManger.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
            }
        }
    }
}

