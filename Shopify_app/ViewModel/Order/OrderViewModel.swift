//
//  OrderViewModel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 07/07/2022.
//

import Foundation

class OrderViewModel{
    
}

//extension OrderViewModel{
//    func calcTotalPrice(completion: @escaping (Double?)-> Void){
//        var totalPrice: Double = 0.0
//        getItemsInCart { orders, error in
//            if error == nil {
//                guard let orders = orders, let customerID = self.customerID  else { return }
//                for item in orders{
//                    if item.userID == customerID {
//                        guard let priceStr = item.itemPrice, let price = Double(priceStr) else { return }
//                        totalPrice += Double(item.itemQuantity) * price
//                    }
//                }
//                Helper.shared.setTotalPrice(totalPrice: totalPrice)
//                completion(totalPrice)
//            }else{
//                completion(nil)
//            }
//        }
//    }
//}
