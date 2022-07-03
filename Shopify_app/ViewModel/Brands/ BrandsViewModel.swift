//
//   BrandsViewModel.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 01/12/1443 AH.
//

import Foundation

class BrandsViewModel{
    
    var brandsArray: [Smart_collections]? {
        didSet{
            updateData(brandsArray, nil)
        }
    }
    var error: Error? {
        didSet {
            updateData(nil, error)
        }
    }
    
    let ApiService: ApiService
    var updateData : (([Smart_collections]?,Error?) -> Void) = {_ , _ in}
    init(ApiService: ApiService = NetworkManager()) {
        self.ApiService = ApiService
    }
    
    func fetchData(){
        ApiService.getAllBrands { brands, error in
            if let brands = brands{
                self.brandsArray = brands.smart_collections
            }else{
                self.error = error
            }
        }
    }
    
}
    
