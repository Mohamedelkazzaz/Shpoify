//
//  MyOrdersTV.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 15/12/1443 AH.
//

import UIKit

class MyOrdersTV: UITableViewController {
    
    var myOrdersViewmodel = MyOrdersViewModle()
    var ordersArray : [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        productsData()
       
    }
    
    //MARK: productsData
    func productsData(){
        
        myOrdersViewmodel.fetchData()
        myOrdersViewmodel.updateData = { orders , error in
            if let orders = orders{
                self.ordersArray = orders
                self.tableView.reloadData()
            }
            if let error = error {
                print(error)
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Orders"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath) as! MyOrderCell
        let price = ConvertPrice.getPrice(price: Double(ordersArray[indexPath.row].current_total_price ?? "") ?? 0.0)
        cell.price.text = "\(price)"
        cell.creationDate.text = ordersArray[indexPath.row].created_at
        cell.stat.text = ordersArray[indexPath.row].financial_status
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius  = 20
        cell.clipsToBounds = true

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "MyOrdersDetails", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersDetailsTableViewController") as? MyOrdersDetailsTableViewController
        vc?.items = ordersArray[indexPath.row].line_items ?? []
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
