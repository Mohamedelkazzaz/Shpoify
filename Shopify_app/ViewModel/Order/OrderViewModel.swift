//
//  OrderViewModel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 07/07/2022.
//

import Foundation



class OrderViewModel{
    
    var bindingAlreadyInCartToView : (()->()) = {}
    var bindingDeleteCartToView : (()->()) = {}
    var bindingEmptyCartAlert : (()->()) = {}
    let customerID = ApplicationUserManger.shared.getUserID()

    var showAlreadyExist : (()->()) {
        self.bindingAlreadyInCartToView
    }
    var showDeleteAlert : (()->()) {
        self.bindingDeleteCartToView
    }
    var showEmptyCartAlert : (()->()) {
        self.bindingEmptyCartAlert
    }
    
    func getItemsInCart(complition: @escaping (([Cart]?,Error?)->Void)){
        do {
            let cartItems = try context.fetch(Cart.fetchRequest())
            complition(cartItems, nil)
            
        } catch let error {
            complition(nil, error)
        }
    }
    
    func addItemsToCart(product:Product){
        do {
            let items = try context.fetch(Cart.fetchRequest())
            if checkIfItemExist(id: product.id!,itemms: items){
                print("Already in cart")
                self.showAlreadyExist()
            }else{
                let orderItem = Cart(context: context)
                orderItem.id = Int64(product.id!)
                orderItem.title = product.title
                orderItem.price = product.variants![0].price
                orderItem.image = product.image?.src
                orderItem.quantity = 1
                orderItem.userId = Int64(customerID!)
                try? context.save()
                print(orderItem)
            }
        } catch let error {
            print(error)
        }
    }
    
    func checkIfItemExist(id: Int,itemms:[Cart]) -> Bool {
        var check : Bool = false
        for i in itemms {
            if i.id == id {
                check = true
            }else {
                check = false
            }
        }
        return check
    }
    
    func deleteFromCoreData(indexPath:IndexPath,cartItems:[Cart]){
        context.delete(cartItems[indexPath.row])
        try? context.save()
    }

}


extension OrderViewModel{
    func getSelectedItemInCart(productId: Int64, completion: @escaping (Cart?, Error?)-> Void){
        getItemsInCart { orders, error in
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
    func getSelectedProducts(completion: @escaping ([Cart]?, Error?) -> Void){
        guard let customerID = ApplicationUserManger.shared.getUserID() else {return}
        CoreDataManager.shared.getProductsInCart(customerID: customerID) { carts, error in
            guard let carts = carts, error == nil else {
                completion(nil, error)
                return
            }
            completion(carts, nil)
        }
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
}

   


extension OrderViewModel{
    func calcTotalPrice(completion: @escaping (Double?)-> Void){
        var totalPrice: Double = 0.0
        getItemsInCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID  else { return }
                for item in orders{
                    if item.userId == customerID {
                        guard let priceStr = item.price, let price = Double(priceStr) else { return }
                        totalPrice += Double(item.quantity) * price
                    }
                }
                ApplicationUserManger.shared.setTotalPrice(totalPrice: totalPrice)
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }
}
