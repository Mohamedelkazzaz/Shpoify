//
//  DoneViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 15/07/2022.
//

import UIKit

class DoneViewController: UIViewController {
    @IBOutlet weak var doneImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func continueShopping(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
    }
    
   

}
