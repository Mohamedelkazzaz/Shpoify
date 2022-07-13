//
//  FavoritesViewModel.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import Foundation

class FavoritesViewModel{
    
    var favoritesModel = [Favorites]()
    
    func getFavoriteProducts(completion: @escaping ([Favorites]?, Error?) -> Void){
        guard let customerID = ApplicationUserManger.shared.getUserID() else {return}
        CoreDataManager.shared.fetchFavoriteProductsForCustomer(customerID: customerID)
        { products, error in
            guard let products = products else {
                completion(nil, error)
                return
            }
            completion(products, nil)
        }
    }
    
    func deleteFavoriteProducts(indexPath: IndexPath) {
        let deletedProduct = favoritesModel[indexPath.row]
        CoreDataManager.shared.delete(returnType: Favorites.self, delete: deletedProduct)
        CoreDataManager.shared.fetch(returnType: Favorites.self) {
            (deletion) in
            self.favoritesModel = deletion
            
        }
    }
    func addFavoriteProducts(completion: @escaping ([Favorites]?, Error?) -> Void){
        guard let customerID = ApplicationUserManger.shared.getUserID() else {return}
        CoreDataManager.shared.fetchFavoriteProductsForCustomer(customerID: customerID)
        { products, error in
            guard let products = products else {
                completion(nil, error)
                return
            }
            completion(products, nil)
        }
    }
}
