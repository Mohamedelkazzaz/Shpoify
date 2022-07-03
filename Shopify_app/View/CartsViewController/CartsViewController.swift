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
