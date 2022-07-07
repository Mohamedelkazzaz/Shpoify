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
//    func getSelectedProducts(completion: @escaping ([Cart]?, Error?) -> Void){
//        guard let customerID = ApplicationUserManger.shared.getUserID() else {return}
//        CoreDataManager.shared.getProductsInCart(customerID: customerID) { carts, error in
//            guard let carts = carts, error == nil else {
//                completion(nil, error)
//                return
//            }
//            completion(carts, nil)
//        }
//    }
//}
//
//extension OrderViewModel{
//    func saveProductToCart(){
//        CoreDataManager.shared.saveFavoritesProducts{ saveSuccess in
//            if saveSuccess{
//                print("success to save product in cart")
//            }else{
//                print("failed to save product in cart")
//            }
//        }
//    }
//}

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
