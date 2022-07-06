//
//  AddressViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit
import CloudKit

class AddressViewController: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    
    var viewModel: AddressViewModel = AddressViewModel()
    
    var address = [Customer]()
    var addresses = [Address]()
    let networkManager =  NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        addressTableView.delegate = self
        addressTableView.dataSource = self
        
        addressTableView.register(UINib(nibName: "addAddressCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAddreesesForCoustomer()
        viewModel.bindingData = { address, error in
                DispatchQueue.main.async {
                    self.addressTableView.reloadData()
                }
            
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func addAdressButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Adress", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension AddressViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAddreeses()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! addAddressCell
        cell.setup(address: viewModel.getAddress(indexPath: indexPath))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Confirm this address", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
                
            let vc = UIStoryboard(name: "MyOrder", bundle: nil).instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
            self.navigationController?.pushViewController(vc, animated: true)
            }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
           alert.addAction(action)
           alert.addAction(cancel)

           present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          tableView.beginUpdates()
          let customerId = ApplicationUserManger.shared.getUserID() ?? 0
//          let id = address[indexPath.row].id
          let id = ApplicationUserManger.shared.getAddressID() ?? 0
          print(customerId)
          print(id)
          networkManager.deleteAddressForCustomer(customerId: customerId, id: id ?? 0) {  error in
              if let error = error{
                  print(error.localizedDescription)
                 return
                  
              }
                self.addresses.remove(at: indexPath.row)
                self.addressTableView.deleteRows(at: [indexPath], with: .automatic)
          }
          tableView.endUpdates()
      }
//        self.addressTableView.reloadData()
        
    }
}
