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
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView ()
    }
    func configreView () {
        logintButton.layer.cornerRadius = 10
    }
    @IBAction func tapLoginButton(_ sender: UIButton) {
        
    }
    @IBAction func tapToCreateAccountButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "RegisterationViewController") as! RegisterationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
