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
    
    var array: [String] = ["My Whishlist","My Adrresses","About us","Contact us"]
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
    }
    

}
extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 1
//        
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        title = "My Account"
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingCell
        switch indexPath.row{
        case 0:
            cell.cellImage.image = UIImage(named: "icons8-heart")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.cellImage.image = UIImage(named: "icons8-home")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.cellImage.image = UIImage(named: "icons8-info")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        default:
            cell.cellImage.image = UIImage(named: "icons8-last_24_hours")
            cell.cellImage?.tintColor = .label
            cell.cellName?.text = array[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
