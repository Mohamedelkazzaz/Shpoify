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
               
                let alert = UIAlertController(title: "Missing Data", message: "Please fill your info", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let add = Address(address1: address, city: city, province: city, phone: phone, zip: "", last_name: "", first_name: name, country: country, id: nil)
            
            networkManager.addAddress(customerId: customerId, address: add) { data , res, error in
                if error == nil{
                    print("success to create address")
                    ApplicationUserManger.shared.setFoundAdress(isFoundAddress: true)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    print("falied to create address")
                }
            }
        
    }
    
    
    func checkData() {
        let titleMessage = "Missing Data"
        if countryTextField.text == "" {
            let alert = UIAlertController(title: titleMessage, message: "Please enter your country name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        if cityTextField.text == "" {
            let alert = UIAlertController(title: titleMessage, message: "Please enter your city name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        if addressTextField.text == "" {
            
            let alert = UIAlertController(title: titleMessage, message: "Please enter your address", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        if phoneTextField.text == "" {
            let alert = UIAlertController(title: title, message: "Please enter you phone number", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
                
        } else {
            let check: Bool = validate(value: phoneTextField.text!)
            if check == false {
                let alert = UIAlertController(title: "invalid data!", message: "please enter you phone number in correct format", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        print("RESULT \(result)")
        return result
    }
}
   
}
