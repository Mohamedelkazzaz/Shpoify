//
//  UIViewController+Ext.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 05/07/2022.
//


import Foundation
import UIKit

extension UIViewController{
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController{
    func showConfirmAlert(title:String, message:String, complition:@escaping (Bool)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmBtn = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            complition(true)
        }
        alert.addAction(cancelBtn)
        alert.addAction(confirmBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController{
    func showAlertForInterNetConnection(){
        let alert = UIAlertController(title: "network is not connected", message: "please, check your internet connection for using app..", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showAlertSheet(title:String, message:String,complition:@escaping (Bool)->Void){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let logOut = UIAlertAction(title: "Log out", style: .destructive) { _ in
            complition(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            complition(false)
        }
        actionSheet.addAction(logOut)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}


extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
