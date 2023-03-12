//
//  OrderViewModel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 07/07/2022.
//

import Foundation



class OrderViewModel{
    
    let customerID = ApplicationUserManger.shared.getUserID()
    var order : OrderItem?
    var orderItems : [OrderItem] = []
    var totalOrder = Order()
    let networking = NetworkManager()
    
    
    func fetchItemsFromCart(complition: @escaping (([Cart]?,Error?)->Void)){
        let cartItems = CoreDataManager.shared.fetchDataFromCart()
            complition(cartItems, nil)
    }
    
    func addItemsToCart(product:Product){
        guard let id = product.id else {return}
        if isItemInCart(productId: id){
            print("Already in cart")
            // self.showAlreadyExist()
        }else{
            guard  let id = product.id, let variants = product.variants, let customerID = ApplicationUserManger.shared.getUserID() else {return}
            CoreDataManager.shared.addToCart(id: Int64(id), userId: Int64(customerID), title: product.title!, image: (product.image?.src)!, price: variants[0].price!, quantity: 1)
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
    
    func deleteItemFromeCart(indexPath:IndexPath,cartItems:[Cart]){
        CoreDataManager.shared.delete(delete: cartItems[indexPath.row])
    }
    
}

extension OrderViewModel{
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
    
    func getSelectedProducts(completion: @escaping ([Cart]?, Error?) -> Void){
        //        guard let customerID = ApplicationUserManger.shared.getUserID() else {return}
        //        CoreDataManager.shared.getProductsInCart(customerID: customerID) { carts, error in
        //            guard let carts = carts, error == nil else {
        //                completion(nil, error)
        //                return
        //            }
        //            completion(carts, nil)
        //        }
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
}

extension OrderViewModel{
    func getCustomerId(completion: @escaping (Customer?)-> Void){
        networking.getAll(url: Url.shared.customersURl(), modelType: Customers.self){customers, error in
            guard let customers = customers, error == nil,let customerID = self.customerID else {return}
            
            let filetr = customers.customers.filter { selectedCustomer in
                return selectedCustomer.id == customerID
            }
            if filetr.count != 0{
                completion(filetr[0])
            }else{
                completion(nil)
            }
            
        }
    }
    func postOrdersToApi(cartArray:[Cart]){
        if cartArray.count == 0 {
        }
        else{
            for item in cartArray {
                orderItems.append(OrderItem(variant_id: Int(item.id), quantity: Int(item.quantity), name: nil, price: item.price,title:item.title))
            }
            let totalPrice = ApplicationUserManger.shared.getTotalPrice() ?? 0.0
            let convertedTotalPrice = "\(ConvertPrice.getPrice(price:totalPrice))"
            let orderTotalPrice = convertedTotalPrice
            print("line 159 in order view model \(orderTotalPrice)")
            self.totalOrder.current_total_price = String(convertedTotalPrice)
            self.getCustomerId { customer in
                guard let customer = customer else {return}
                let order = Order(customer: customer, line_items: self.orderItems, current_total_price: orderTotalPrice)
                let ordertoAPI = OrderToAPI(order: order)
                self.networking.addOrder(order: ordertoAPI) { data, urlResponse, error in
                    if error == nil {
                        print("Post order success")
                        if let data = data{
                            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                            let returnedOrder = json["order"] as? Dictionary<String,Any>
                            print("\(returnedOrder!["current_total_price"])")
                            let returnedCustomer = returnedOrder?["customer"] as? Dictionary<String,Any>
                            let id = returnedCustomer?["id"] as? Int ?? 0
                            for i in cartArray {
                                context.delete(i)
                            }
                            try! context.save()
                        }
                    }else{
                        print(error as Any)
                    }
                }
            }
        }
    }
    
    
}
