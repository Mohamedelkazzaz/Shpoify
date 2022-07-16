//
//  FavoritesViewModel.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import Foundation
import ProgressHUD
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
    
    func addItemsToFavorite(product:Product){
        do {
            let items = try context.fetch(Favorites.fetchRequest())
            if isItemExist(productId: product.id!,Items: items){
               // print("Already in favorite")
            }else{
                let products = Favorites(context: context)
                products.productID = Int64(product.id!)
                products.productName = product.title
                products.productPrice = product.variants![0].price
                products.productImage = product.image?.src
                products.customerID = Int64(ApplicationUserManger.shared.getUserID()!)
                try? context.save()
                ProgressHUD.colorAnimation = .systemRed
                ProgressHUD.show("Add to favorite", icon: .heart)
            }
        } catch let error {
            print(error)
        }
    }
    
    func isItemExist(productId: Int,Items:[Favorites]) -> Bool {
        var check : Bool = false
        for i in Items {
            if i.productID == productId {
                check = true
            }else {
                check = false
            }
        }
        return check
    }
}
