//
//  NetworkManager.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager: ApiService{
    
    func getAllBrands(complition: @escaping (Brands?, Error?)->Void){
        
        guard let url = Url.shared.getAllBrandsURl() else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Brands.self, from: data)
                    DispatchQueue.main.async{
                        complition(json, nil)
                        print("success to get all brands")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print("error when get All brands")
                        complition(nil, error)
                    }
                }
            }
            if let error = error{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func getAllProducts(complition: @escaping (Products?, Error?) -> Void) {
        guard let url = Url.shared.getAllProductsURL() else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Products.self, from: data)
                    DispatchQueue.main.async{
                        complition(json, nil)
                        print("success to get all products")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print("error when get All products")
                        complition(nil, error)
                    }
                }
            }
            if let error = error{
                print(error)
            }
        }.resume()
    }
    
    func getProductsByCategory(collectionId:String,complition: @escaping (Products?, Error?) -> Void) {
        guard let url = Url.shared.getProductsByCategory(collectionId: collectionId) else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(Products.self, from: data)
                    DispatchQueue.main.async{
                        complition(json, nil)
                        print("success to get all products")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print("error when get All products")
                        complition(nil, error)
                    }
                }
            }
            if let error = error{
                print(error)
            }
        }.resume()
    }
}
