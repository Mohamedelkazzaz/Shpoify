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
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func registerNewCustomer() -> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func ordersURL()->URL?{
        return URL(string: baseURL + "orders.json")
    }
    func getLoginPath()-> URL?{
        return URL(string: baseURL + "account/login")
    }
    func getCurrency() -> URL?{
        return URL(string: "https://api.currencyapi.com/v3/latest?apikey=PtNixexh5FlMMVO0gzlvNt7Lx9s8nUJ1cvq2u8dK&currencies=EGP")
    }
    func getAddressForCustomer(customerID: String) -> URL? {
        return URL(string: baseURL + "customers/\(customerID)/addresses.json")
    }
    func addAddress(id: String) -> URL? {
            return URL(string: baseURL + "customers/\(id).json")
        }
    func deleteAddress(customerID: String, id: String) -> URL?{
            return URL(string: baseURL + "customers/\(customerID)/addresses/\(id).json")
        }
    func getDiscount(priceRuleId: String) -> URL?{
        return URL(string: baseURL + "price_rules/\(priceRuleId)/discount_codes.json")

    }
    func deleteDiscount(priceRuleId: String,discountCodeId: String) -> URL?{
        return URL(string: baseURL + "price_rules/\(priceRuleId)/discount_codes/\(discountCodeId).json")

    }
    func getProductsByCategory(collectionId:String)-> URL?{
        return URL(string: baseURL + "products.json?collection_id=\(collectionId)")
    }
    func getOrdersUser(customerId:Int)->URL?{
        return URL(string: baseURL + "customers/\(customerId)/orders.json")
    }
}

enum Endpoints {
    private var baseURL: String { return "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-01/" }
    
    case smart_collections  // brands
    case Products
    case customers
    case orders
    case getLoginPath
    case getCurrency
    case getAddressForCustomer(String)
    case addAddress(String)
    case deleteAddress(String,String)
    case getDiscount(String)
    case deleteDiscount(String,String)
    case getProductsByCategory(String)
    case getOrdersUser(String)
    
    private var fullPath: String {
        var endpoint:String
        switch self {
        case .getLoginPath:
            endpoint = "account/login"
        case .getCurrency:
            return "https://api.currencyapi.com/v3/latest?apikey=PtNixexh5FlMMVO0gzlvNt7Lx9s8nUJ1cvq2u8dK&currencies=EGP"
        case .getAddressForCustomer(let customerID):
            endpoint = "customers/\(customerID)/addresses.json"
        case .addAddress(let id):
            endpoint = "customers/\(id).json"
        case .deleteAddress(let customerID,let id):
            endpoint = "customers/\(customerID)/addresses/\(id).json"
        case .getDiscount(let priceRuleId):
            endpoint = "price_rules/\(priceRuleId)/discount_codes.json"
        case .deleteDiscount(let priceRuleId,let discountCodeId):
            endpoint =  "price_rules/\(priceRuleId)/discount_codes/\(discountCodeId).json"
        case .getProductsByCategory(let collectionId):
            endpoint = "products.json?collection_id=\(collectionId)"
        case .getOrdersUser(let customerId):
            endpoint = "customers/\(customerId)/orders.json"
        default:
            endpoint = "\(String(describing: self)).json"
        }
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(Endpoints.self) is not valid")
        }
        return url
    }
}
