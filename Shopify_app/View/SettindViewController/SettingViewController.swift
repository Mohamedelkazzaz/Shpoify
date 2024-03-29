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
    
    @IBOutlet weak var logoutButton: UIButton!
//    var isSelect = false

    var array: [String] = ["My Orders","My Whishlist","My Adrresses","About us"]

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        if (ApplicationUserManger.shared.getUserStatus()){
            profileTableView.delegate = self
            profileTableView.dataSource = self
            logoutButton.setTitle("logout", for: .normal)
         
            nameLabel.text = ApplicationUserManger.shared.getUserName()
        }
        else{
            logoutButton.setTitle("login", for: .normal)
          
        }
        
//        if ApplicationUserManger.shared.getSelectedCurrency(){
//            ApplicationUserManger.shared.setSelectedCurrency(isUSD: true)
//            currecySegment.selectedSegmentTintColor = .blue
//        }else{
//            ApplicationUserManger.shared.setSelectedCurrency(isUSD: false)
//            currecySegment.selectedSegmentTintColor = .yellow
//        }
        
        if ApplicationUserManger.shared.getSelectedCurrency(){
            currecySegment.selectedSegmentIndex = 0
        }else {
            currecySegment.selectedSegmentIndex = 1
        }
        
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        if (ApplicationUserManger.shared.getUserStatus()){
            ApplicationUserManger.shared.setUserStatus(userIsLogged: false)
            ApplicationUserManger.shared.setUserID(customerID: 0)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            logoutButton.titleLabel?.text = "logout"
            self.present(nav, animated: true, completion: nil)
        }else{
            logoutButton.titleLabel?.text = "login"
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            //empty cart
            let cartArray = CoreDataManager.shared.fetchDataFromCart()
            for i in cartArray {
                context.delete(i)
            }
            try! context.save()
            //empty favrit
            let favoritArray = CoreDataManager.shared.fetchDataFromFavorit()
            for i in favoritArray {
                context.delete(i)
            }
            try! context.save()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        if (ApplicationUserManger.shared.getUserStatus()){
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartsViewController") as! CartsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        switch currecySegment.selectedSegmentIndex {
                case 0:
            ApplicationUserManger.shared.setSelectedCurrency(isUSD: true)
            SettingViewController.changeRoot()
        case 1 :
            ApplicationUserManger.shared.setSelectedCurrency(isUSD: false)
            SettingViewController.changeRoot()
                default:
                    break
                }
    }
    
    static func changeRoot(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
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
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 15
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
            let vc = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
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
