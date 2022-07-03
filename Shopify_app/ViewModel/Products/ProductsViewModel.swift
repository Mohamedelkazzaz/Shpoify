//
//  ProductsViewModle.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import Foundation

class ProductsViewModel{
    
    var productsArray: [Product]? {
        didSet{
            updateData(productsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let ApiService: ApiService
    var updateData : (([Product]?,Error?) -> Void) = {_ , _ in}
    init(ApiService: ApiService = NetworkManager()) {
        self.ApiService = ApiService
    }
    
    func fetchData(){
        ApiService.getAllProducts { products, error in
            if let products = products{
                self.productsArray = products.products
            }else{
                self.error = error
            }
        }
    }
    
}
