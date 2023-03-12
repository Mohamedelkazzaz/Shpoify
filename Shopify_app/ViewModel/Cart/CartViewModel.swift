//
//  CartViewModel.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 05/03/2023.
//

import Foundation

class CartViewModel{
    
    let customerID = ApplicationUserManger.shared.getUserID()
    
    func fetchItemsFromCart(complition: @escaping (([Cart]?,Error?)->Void)){
            let cartItems =  CoreDataManager.shared.fetchDataFromCart() //try context.fetch(Cart.fetchRequest())
            complition(cartItems, nil)
    }
    
    func deleteItemFromeCart(indexPath:IndexPath,cartItems:[Cart]){
        CoreDataManager.shared.delete(delete: cartItems[indexPath.row])
       // context.delete(cartItems[indexPath.row])
        try? context.save()
    }
    
    func saveProductToCart(){
        CoreDataManager.shared.saveFavoritesProducts{ saveSuccess in
            if saveSuccess{
                print("success to save product in cart")
            }else{
                print("failed to save product in cart")
            }
        }
    }
    
    func addItemsToCart(product:Product){
        do {
            guard let id = product.id else {return}
            if isItemInCart(productId: id){
                print("Already in cart")
                // self.showAlreadyExist()
            }else{
                let order = Cart(context: context)
                order.id = Int64(product.id!)
                order.title = product.title
                order.price = product.variants![0].price
                order.image = product.image?.src
                order.quantity = 1
                order.userId = Int64(customerID!)
                try? context.save()
               
            }
        } catch let error {
            print(error)
        }
    }
    
    func isItemInCart(productId: Int) -> Bool {
        let cartsItems = CoreDataManager.shared.fetchDataFromCart()
        var check : Bool = false
        for i in cartsItems {
            if i.id == productId {
                check = true
            }else {
                check = false
            }
        }
        return check
    }
    
    func calcTotalPrice(completion: @escaping (Double?)-> Void){
        var totalPrice: Double = 0.0
        fetchItemsFromCart { orders, error in
            if error == nil {
               guard let orders = orders, let customerID = self.customerID  else { return }
                for item in orders{
                    if item.userId == customerID {
                        guard let priceStr = item.price, let price = Double(priceStr) else { return }
                        totalPrice += Double(item.quantity) * price
                    }
                }
                print("line 123 in order view model \(totalPrice)")
                ApplicationUserManger.shared.setTotalPrice(totalPrice: totalPrice)
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }

    func getSelectedItemInCart(productId: Int64, completion: @escaping (Cart?, Error?)-> Void){
        fetchItemsFromCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID else { return }
                for item in orders {
                    if item.id == productId && item.userId == customerID {
                        completion(item, nil)
                    }
                }
            }else{
                completion(nil, error)
            }
        }
    }
}
