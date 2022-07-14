//
//  ConvertPrice.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 14/07/2022.
//

import Foundation

class ConvertPrice{
    static func getPrice(price: Double) -> Double{
        if ApplicationUserManger.shared.getSelectedCurrency(){
            return price
        }
        print(ApplicationUserManger.shared.getCurrency())
        return (price * (ApplicationUserManger.shared.getCurrency() ?? 0.0))
    }
}
