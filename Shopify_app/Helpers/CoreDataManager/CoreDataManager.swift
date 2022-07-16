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
                print("Error in Saving Favorite Products", error)
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
                print("Error in Fetching Favorite Products: ", error)
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
            print("Error", error)
        }
    }
    
    func delete<T: NSManagedObject>(returnType: T.Type, delete: T) {
        context.delete(delete.self)
        do {
            try context.save()
            
        }catch {
            print("Products not deleted", error)
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
    
    func addToFavorites(id: Int64, pid: Int64, name: String, pimage: String,Price: String){

        if let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: context){

            let CoreProduct = NSManagedObject(entity: entity, insertInto: context)
            CoreProduct.setValue(id, forKey: "customerID")
            CoreProduct.setValue(pid, forKey: "productID")
            CoreProduct.setValue(name, forKey: "productName")
            CoreProduct.setValue(pimage, forKey: "productImage")
            CoreProduct.setValue(Price, forKey: "productPrice")
            do {
                try context.save()
                print(" sucss add")
            }catch let error as NSError {
                print("Error in saving")
                print(error.localizedDescription)
            }
        }
    }
    
    func addToCart(appDelegate: AppDelegate,id: Int64,userId: Int64, title: String, image:String, price: String, quantity: Int64){
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Cart", in: manageContext){
            let cart = NSManagedObject(entity: entity, insertInto: manageContext)
            cart.setValue(id, forKey: "id")
            cart.setValue(userId, forKey: "userId")
            cart.setValue(title, forKey: "title")
            cart.setValue(image, forKey: "image")
            cart.setValue(price, forKey: "price")
            cart.setValue(quantity, forKey: "quantity")
            

            do {
                try manageContext.save()
            }catch let error as NSError {
                print("Error in saving")
                print(error.localizedDescription)
            }
        }
    }

    func fetchDataFromFavorit() -> [Favorites]{

        var fetchedList : [Favorites] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")

        do{
            fetchedList = try context.fetch(fetchRequest) as! [Favorites]
            print("sucess fetch")
        }catch let error as NSError {
            print("Error in saving")
            print(error.localizedDescription)
        }
        return fetchedList
    }
    
    func fetchDataFromCart() -> [Cart]{

        var fetchedList : [Cart] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")

        do{
            fetchedList = try context.fetch(fetchRequest) as! [Cart]
            print("sucess fetch")
        }catch let error as NSError {
            print("Error in saving")
            print(error.localizedDescription)
        }
        return fetchedList
    }
    
    func deleteProduct(Core:Favorites){
        context.delete(Core)
        do{
            try context.save()
            print("deleted")
        }catch let error as NSError{
            print("Error in saving")
            print(error.localizedDescription)
        }
    }
}
