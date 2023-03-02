//
//  ProductDetailsViewModel.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import Foundation


class ProductDetailsViewModel {
    
    var favoritesModel = Favorites()
    
    func saveToFavorites() {
        CoreDataManager.shared.saveFavoritesProducts {  saved in
            if saved {
                print("product saved in Favorites")
            } else {
                print("Error in saving Products")
            }
        }
    }
    
    func deletefromFavorites (productID: Int) {
        CoreDataManager.shared.getFavoriteProducts { [self] FavoriteProducts, error in
            guard let FavoriteProducts = FavoriteProducts,
                  let customerID = ApplicationUserManger.shared.getUserID() else {
                return}
            
            for specifiedProduct in FavoriteProducts{
                if specifiedProduct.customerID == customerID && specifiedProduct.productID == productID {
                    CoreDataManager.shared.delete(delete: favoritesModel.self)
                }
            }
        }
    }
    
    func checkProductsInFavorites(productID: Int, completion: @escaping (Bool) -> Void) {
        CoreDataManager.shared.getFavoriteProducts {
            favoriteProducts, error in
            guard let favoriteProducts = favoriteProducts,
            let customerID = ApplicationUserManger.shared.getUserID()  else {
                return  }
            
            for specifiedProduct in favoriteProducts{
                if specifiedProduct.customerID == customerID && specifiedProduct.productID == productID { completion(true)
                    
                }
            }
        }
    }
}
