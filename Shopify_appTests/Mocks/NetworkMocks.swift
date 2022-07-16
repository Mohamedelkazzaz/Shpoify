//
//  NetworkMocks.swift
//  Shopify_appTests
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//

import Foundation

@testable import Shopify_app

class NetworkManagerMock:ApiService{
   
   
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    
    let jsonResponse : [String : [[String : Any]]] =
    [
        "customers": [
            [
                "id": 6277923504342,
                "email": "ibrahhim@gmail.com",
                "accepts_marketing": false,
                "created_at": "2022-07-15T20:56:21+02:00",
                "updated_at": "2022-07-15T20:56:21+02:00",
                "first_name": "hem",
                "last_name": "a",
                "orders_count": 0,
                "state": "disabled",
                "total_spent": "0.00",
                "last_order_id": "null",
                "note": "null",
                "verified_email": true,
                "multipass_identifier": "null",
                "tax_exempt": false,
                "phone": "null",
                "tags": "123456",
                "last_order_name": "null",
                "currency": "EGP",
                "addresses": [],
                "accepts_marketing_updated_at": "2022-07-15T20:56:21+02:00",
                "marketing_opt_in_level": "null",
                "tax_exemptions": [],
                "sms_marketing_consent": "null",
                "admin_graphql_api_id": "gid://shopify/Customer/6277923504342"
            ]
                ]
        ]
                
    func getAllBrands(complition: @escaping (Brands?, Error?) -> Void) {
            print("")
        
    }
    
    func getAllProducts(complition: @escaping (Products?, Error?) -> Void) {
        print("")
    }
    
    func getProductsByCategory(collectionId: String, complition: @escaping (Products?, Error?) -> Void) {
        print("")
    }
    
    func addAddress(customerId: Int, address: Address, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        print("")
    }
    
    func register(newCustomer: NewCustomer, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        print("")
    }
    
    func getAllCustomers(complition: @escaping (Customers?, Error?) -> Void) {
        switch self.shouldReturnError {
            case true :
                complition(nil, NetworkError.failedFetchingData)
            case false:
                if let data = try? JSONSerialization.data(withJSONObject: self.jsonResponse, options: .fragmentsAllowed) {
                    print(data)
                    let jsonDecoder = JSONDecoder()
                    let decodedArray = try? jsonDecoder.decode(Customers.self, from: data)
//                    if let decodedArray: Customers = convertFromJson(data: data) {
                        complition(decodedArray,nil)
                        
                    } else { complition(nil, NetworkError.failedFetchingData) }
                    
                } //else { complition(nil, NetworkError.failedFetchingData) }
        //}
    }
    
    func getAddressForCustomer(customerId: Int, completion: @escaping (Customer?, Error?) -> Void) {
        print("")
    }
    
    func deleteAddressForCustomer(customerId: Int, id: Int, completion: @escaping (Error?) -> ()) {
        print("")
    }
    
    func getOrdersForCustomer(customerId: Int, completion: @escaping (OrdersFromAPI?, Error?) -> Void) {
        print("")
    }
    
    func addOrder(order: OrderToAPI, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print("")
    }
    
    func getDiscounts(priceRuleId: Int, complition: @escaping (DiscountModel?, Error?) -> Void) {
        print("")
    }
    
    func deleteDiscount(priceRuleId: Int, discountCodeId: Int, completion: @escaping (Error?) -> ()) {
        print("")
    }
    
    func getCurrency() {
        print("")
    }
    

}


enum NetworkError: Error {
    case failedFetchingData
}
