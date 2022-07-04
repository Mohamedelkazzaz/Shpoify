//
//  AddressViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit

class AddressViewController: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    
    var viewModel: AddressViewModel = AddressViewModel()
    
    let address = [Customer]()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
