//
//  SettingViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit


class SettingViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currecySegment: UISegmentedControl!
    


    var array: [String] = ["My Orders","My Whishlist","My Adrresses","About us"]

    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
        nameLabel.text = ApplicationUserManger.shared.getUserName()
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        if (ApplicationUserManger.shared.getUserStatus()){
            ApplicationUserManger.shared.setUserStatus(userIsLogged: false)
            ApplicationUserManger.shared.setUserID(customerID: 0)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }else{
        
        }
    }
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartsViewController") as! CartsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        switch currecySegment.selectedSegmentIndex {
                case 0:
            print("USD")
            ApplicationUserManger.shared.setSelectedCurrency(isUSD: true)
                case 1 :
            print("EGP")
            ApplicationUserManger.shared.setSelectedCurrency(isUSD: false)
                default:
                    break
                }
    }
    

}


extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title : String?
        title = "My Account"
        return title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingCell
        switch indexPath.row{
        case 0:
            cell.cellImage.image = UIImage(systemName: "bag")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.cellImage.image = UIImage(named: "icons8-heart")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.cellImage.image = UIImage(named: "icons8-home")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator

        default:
            cell.cellImage.image = UIImage(named: "icons8-info")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.selectionStyle = .none

            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "MyLastOreders", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersTV") as! MyOrdersTV 
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Adress", bundle: nil).instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = UIStoryboard(name: "Adress", bundle: nil).instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
//            vc.viewModel = AddressViewModel()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.present(vc, animated: true)
        }
    }

    
}
