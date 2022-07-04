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
    
    func addAddress(customerId: Int, address: Address, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let customer = CustomerAddress(addresses: [address])
        let putObject = PutAddress(customer: customer)
        guard let url = Url.shared.addAddress(id: "6262628057302") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
//        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: putObject.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
        completion(data, response, error)
        }.resume()
    }
    
    func getAddressForCustomer(customerId: Int, completion: @escaping (Customer?, Error?) -> Void) {
        guard let url = Url.shared.getAddressForCustomer(customerID: "6261211300054") else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
                print(String(data: data, encoding: .utf8))
                do{
                    let json = try JSONDecoder().decode(Customer.self, from: data)
                    DispatchQueue.main.async{
                        completion(json, nil)
                        print("success to get all Addreeses")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                       print(error)
                        completion(nil, error)
                    }
                }
            }
            if let error = error{
                print(error)
            }
        }.resume()
    }
    

}
