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
    var orderProducts : [OrderItem] = []
    var totalOrder = Order()
    let networking = NetworkManager()
    
    
    func fetchItemsFromCart(complition: @escaping (([Cart]?,Error?)->Void)){
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
            if isItemExist(productId: product.id!,cartsItems: items){
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
    
    func isItemExist(productId: Int,cartsItems:[Cart]) -> Bool {
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
        context.delete(cartItems[indexPath.row])
        try? context.save()
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
                print("line 123 \(totalPrice)")
               // ApplicationUserManger.shared.setTotalPrice(totalPrice: totalPrice)
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }
}

extension OrderViewModel{
    func getCustomer(completion: @escaping (Customer?)-> Void){
        networking.getAllCustomers { customers, error in
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
                orderProducts.append(OrderItem(variant_id: Int(item.id), quantity: Int(item.quantity), name: nil, price: item.price,title:item.title))
            }
//            self.calcTotalPrice { total in
//                guard let total = total else { return }
//                var totalPrice = ApplicationUserManger.shared.getTotalPrice() ?? 0.0
//             //   print("line 157 \(totalPrice)")
//                let ConvertedtotalPrice = "\(ConvertPrice.getPrice(price:totalPrice))"
//              //  print(ConvertedtotalPrice)
//                self.totalOrder.current_total_price = String(ConvertedtotalPrice)
//
//            }
            var totalPrice = ApplicationUserManger.shared.getTotalPrice() ?? 0.0
            print("line 66 \(totalPrice)")
            let ConvertedtotalPrice = "\(ConvertPrice.getPrice(price:totalPrice))"
            print("line 66 \(ConvertedtotalPrice )")
            self.totalOrder.current_total_price = String(ConvertedtotalPrice)
            
            self.getCustomer { customer in
                guard let customer = customer else {return}
             
                let order = Order(customer: customer, line_items: self.orderProducts, current_total_price: self.totalOrder.current_total_price)
                print("line 169 \(self.totalOrder.current_total_price)")
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
                        print(error)
                    }
                }
            }
        }
    }
    
    
}
