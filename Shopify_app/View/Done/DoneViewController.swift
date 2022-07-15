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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
   

}
