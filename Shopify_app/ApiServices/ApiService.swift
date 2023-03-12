//
//  ApiService.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import Foundation
import CloudKit

// typealias Handler = ((Brands?, Error?)->Void)
typealias Handler<T> = (T?, Error?) -> Void

protocol ApiService{
    
   //getAll Brands/Products/Customers
    func getAll<T:Codable>(url:URL?,modelType: T.Type,complition:@escaping Handler<T>)
    
    func getProductsByCategory(collectionId:String,complition: @escaping (Products?, Error?)->Void)
   

    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->())
    
    func addAddress(customerId: Int, address: Address, completion: @escaping(Data?, HTTPURLResponse?, Error?)->())
    func getAddressForCustomer(customerId: Int,completion: @escaping (Customer?, Error?)->Void)
    func deleteAddressForCustomer(customerId: Int,id: Int,completion: @escaping ( Error?)->())

    func getOrdersForCustomer(customerId: Int, completion: @escaping (OrdersFromAPI?, Error?) -> Void)
    func addOrder(order:OrderToAPI,completion: @escaping (Data?,URLResponse?,Error?)->Void)
   

    func getDiscounts(priceRuleId: Int,complition: @escaping (DiscountModel?, Error?)->Void)
    func deleteDiscount(priceRuleId: Int,discountCodeId: Int,completion: @escaping ( Error?)->())
    


    
    func getCurrency()

}


