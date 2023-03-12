//
//  AddAddressViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let networkManager =  NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.text = "Egypt"
        
    }
    
    @IBAction func addAddressButton(_ sender: UIButton) {
        
        checkData()
        if addressTextField.text != "" && cityTextField.text != "" && countryTextField.text != "" && phoneTextField.text != ""
        {
            guard let customerId = ApplicationUserManger.shared.getUserID(), let name = ApplicationUserManger.shared.getUserName() ,let address = addressTextField.text, !address.isEmpty, let country = countryTextField.text, !country.isEmpty, let city = cityTextField.text, !city.isEmpty, let phone = phoneTextField.text, !phone.isEmpty, phone.count == 11 else {
                showAlertError(title: "Missing Data", message: "Please fill your info")
                return
            }
        
            let add = Address(address1: address, city: city, province: "", phone: phone, zip: "", last_name: "", first_name: name, country: country, id: nil)
            
            networkManager.addAddress(customerId: customerId, address: add){ data,res,error in
                if error == nil{
                    print("success to create address")
                    ApplicationUserManger.shared.setFoundAdress(isFoundAddress: true)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    print("falied to create address")
                }
            }
        
    }
    
    
    func checkData() {
        let titleMessage = "Missing Data"
        if countryTextField.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your country name")
        }
            
        if cityTextField.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your city name")
        }
            
        if addressTextField.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your address")
        }
            
        if phoneTextField.text == "" {
            showAlertError(title: titleMessage, message: "Please enter you phone number")
                
        } else {
            let check: Bool = validate(value: phoneTextField.text!)
            if check == false {
                showAlertError(title: "invalid data!", message: "please enter you phone number in correct format")
            }
        }
    }

    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
}
   
}
