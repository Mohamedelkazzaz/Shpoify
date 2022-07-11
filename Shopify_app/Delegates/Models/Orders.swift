//
//  Orders.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 09/12/1443 AH.
//

import Foundation

struct OrderItem : Codable{
    var variant_id : Int?
    var quantity:Int?
    var name:String?
    var price:String?
    var title:String?
}

struct Order : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[OrderItem]?
    var created_at:String?
    var financial_status: String = "paid"
    var current_total_price:String?
}

struct OrderToAPI : Codable{
    var order : Order
}

struct OrdersFromAPI : Codable {
    var orders : [Order]
}
