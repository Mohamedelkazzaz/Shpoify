//
//  CoreDataManager.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
        func saveFavoritesProducts(completion: @escaping (Bool)-> Void) {
            do {
                try context.save()
                completion(true)
            }catch{
                print("Error in Saving Favorite Products", error.localizedDescription)
                completion(false)
            }
        }
    
        func getFavoriteProducts(completion: @escaping ([Favorites]?, Error?) -> Void ) {
            do{
                let favoriteProducts = try context.fetch(Favorites.fetchRequest())
                print("fetching data from Core DaTa")
                completion(favoriteProducts, nil)
            } catch {
                completion(nil, error)
                print("Error in Fetching Favorite Products: ", error.localizedDescription)
            }
        }
    
    func fetchFavoriteProductsForCustomer(customerID: Int, completion: @escaping([Favorites]?, Error?) -> Void) {
        do {
            let favoriteProducts = try context.fetch(Favorites.fetchRequest())
            var specifiedFavorites: [Favorites] = []
            for customer in favoriteProducts {
                if customer.customerID == customerID {
                    specifiedFavorites.append(customer)
                }
            }
            completion(specifiedFavorites, nil)
        } catch {
            completion(nil, error)
            print("Error", error.localizedDescription)
        }
    }
    
    func delete<T: NSManagedObject>(returnType: T.Type, delete: T) {
        context.delete(delete.self)
        do {
            try context.save()
            
        }catch {
            print("Products not deleted", error.localizedDescription)
        }
    }
    
    func fetch<T: NSManagedObject>(returnType: T.Type , completion: @escaping ([T]) -> Void) {
        do {
            guard let result = try context.fetch(returnType.fetchRequest()) as? [T] else {
                return
            }
            completion(result)
        } catch {
            //
        }
    }
    
}
