//
//  AddressViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit

class AddressViewController: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addressTableView.delegate = self
        addressTableView.dataSource = self
        
        addressTableView.register(UINib(nibName: "addAddressCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @IBAction func addAdressButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Adress", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension AddressViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! addAddressCell
        cell.addressLabel.text = "Janakless ads"
        cell.cityLabel.text = "Alexandria"
        cell.countryLabel.text = "Egypt"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
