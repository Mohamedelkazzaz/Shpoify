//
//  Currency.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 14/07/2022.
//

import Foundation

let networkManager = NetworkManager()
struct Currency{
    func updateCurrency(){
        networkManager.getCurrency()
    }
    
    
}
