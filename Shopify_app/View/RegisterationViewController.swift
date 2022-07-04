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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreView ()
    }
    func configreView () {
        createAccountBtn.layer.cornerRadius = 10
    }
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
    }

}
