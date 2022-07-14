//
//  MyOrdersViewModle.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 15/12/1443 AH.
//

import Foundation
class MyOrdersViewModle{
    
    var OrdersArray: [Order]? {
        didSet{
            updateData(OrdersArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let ApiService: ApiService
    var updateData : (([Order]?,Error?) -> Void) = {_ , _ in}
    init(ApiService: ApiService = NetworkManager()) {
        self.ApiService = ApiService
    }
    
    func fetchData(){
        var id = ApplicationUserManger.shared.getUserID()
        ApiService.getOrdersForCustomer(customerId: id ?? 0) { orders, error in
            if let orders = orders {
                self.OrdersArray = orders.orders
            }
            else{
                self.error = error
            }
        }
    }
}
