//
//  Url.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import Foundation
 
struct Url {
    static let shared = Url()
    let baseURL = "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-01/"
    
    func getAllBrandsURl()-> URL?{
        return URL(string: baseURL + "smart_collections.json")
    }
    
    func getAllProductsURL()-> URL?{
        return URL(string: baseURL + "products.json")
    }

  
    func getProductsByCategory(collectionId:String)-> URL?{
        return URL(string: baseURL + "products.json?collection_id=\(collectionId)")
    }
    
    func addAddress(id: String) -> URL? {
            return URL(string: baseURL + "customers/\(id).json")
        }
    
    func getAddressForCustomer(customerID: String) -> URL? {
        return URL(string: baseURL + "customers/\(customerID)/addresses.json")
    }
    func getLoginPath()-> URL?{
        return URL(string: baseURL + "account/login")
    }
    func registerNewCustomer() -> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func deleteAddress(customerID: String, id: String) -> URL?{
            return URL(string: baseURL + "customers/\(customerID)/addresses/\(id).json")
        }

    
    func ordersURL()->URL?{
        return URL(string: baseURL + "orders.json")
    }
    func getDiscount(priceRuleId: String) -> URL?{
        return URL(string: baseURL + "price_rules/\(priceRuleId)/discount_codes.json")

    }
    
    func deleteDiscount(priceRuleId: String,discountCodeId: String) -> URL?{
        return URL(string: baseURL + "price_rules/\(priceRuleId)/discount_codes/\(discountCodeId).json")

    }


}
