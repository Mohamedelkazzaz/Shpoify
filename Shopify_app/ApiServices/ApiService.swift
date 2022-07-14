//
//  ApiService.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import Foundation
import CloudKit

protocol ApiService{
    func getAllBrands(complition: @escaping (Brands?, Error?)->Void)
    func getAllProducts(complition: @escaping (Products?, Error?)->Void)
    func getProductsByCategory(collectionId:String,complition: @escaping (Products?, Error?)->Void)
    func addAddress(customerId: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->())

    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->())
    func getAllCustomers(complition: @escaping (Customers?, Error?)->Void)

    func getAddressForCustomer(customerId: Int,completion: @escaping (Customer?, Error?)->Void)
    func deleteAddressForCustomer(customerId: Int,id: Int,completion: @escaping ( Error?)->())

    func getOrdersForCustomer(customerId: Int, completion: @escaping (OrdersFromAPI?, Error?) -> Void)
    func addOrder(order:OrderToAPI,completion: @escaping (Data?,URLResponse?,Error?)->Void)
   

    func getDiscounts(priceRuleId: Int,complition: @escaping (DiscountModel?, Error?)->Void)
    func deleteDiscount(priceRuleId: Int,discountCodeId: Int,completion: @escaping ( Error?)->())
    

}


