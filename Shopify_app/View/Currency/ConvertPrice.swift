//
//  ConvertPrice.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 14/07/2022.
//

import Foundation

class ConvertPrice{
    static func getPrice(price: Double) -> String{
      
        if ApplicationUserManger.shared.getSelectedCurrency(){
            let price = round(price * 100) / 100
            return "\(price) USD"
        }

//        print(ApplicationUserManger.shared.getCurrency())
//        return round((price * (Double(ApplicationUserManger.shared.getCurrency() ?? "") ?? 0.0)) * 100) / 100.0
        let price = round((price * (Double(ApplicationUserManger.shared.getCurrency() ?? "") ?? 0.0)) * 100) / 100.0
        
        return "\(price) EGP"

    }
    
    static func convertPrice(price: Double) -> Double{
        if ApplicationUserManger.shared.getSelectedCurrency(){
            
            return round(price * 100) / 100
        }
        return round((price * (Double(ApplicationUserManger.shared.getCurrency() ?? "") ?? 0.0)) * 100) / 100.0
//        return (price * (Double(ApplicationUserManger.shared.getCurrency() ?? "") ?? 0.0))
    }
}
