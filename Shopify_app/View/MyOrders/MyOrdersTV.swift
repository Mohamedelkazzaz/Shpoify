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
                print(error.localizedDescription)
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ordersArray.count)
        return ordersArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Orders"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath) as! MyOrderCell
        
       
        cell.price.text = ordersArray[indexPath.row].current_total_price?.appending(" USD")
        cell.creationDate.text = ordersArray[indexPath.row].created_at
//        cell.createdAt.text = ordersArray[indexPath.row].created_at
//        cell.price.text = ordersArray[indexPath.row].current_total_price?.appending(" USD")
//        cell.paid.text = ordersArray[indexPath.row].financial_status
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "MyOrdersDetails", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersDetailsTableViewController") as? MyOrdersDetailsTableViewController
        vc?.items = ordersArray[indexPath.row].line_items ?? []
        navigationController?.pushViewController(vc!, animated: true)
    }
    

    
}
