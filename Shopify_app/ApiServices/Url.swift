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
}
