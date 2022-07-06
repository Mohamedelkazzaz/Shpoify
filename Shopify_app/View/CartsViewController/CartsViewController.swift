//
//  CartsViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 01/07/2022.
//

import UIKit

class CartsViewController: UIViewController {
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsTableView.delegate = self
        cardsTableView.dataSource = self

        cardsTableView.register(UINib(nibName: "CartsCell", bundle: nil), forCellReuseIdentifier: "cartCell")
    }
    
    @IBAction func checkOutButton(_ sender: UIButton) {
        if priceLabel.text != "/(0)"{
            let storyBoard = UIStoryboard(name: "Adress", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddressViewController") as!AddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "There is no items in cart.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension CartsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
