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
        URLSession.shared.dataTask(with: url) { data, response, error in
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

    func getAllCustomers(complition: @escaping (Customers?, Error?)->Void){
        guard let url = Url.shared.customersURl() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in

            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):

                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(Customers.self, from: data)
                    complition(json, nil)
                    print("success to get customers")
                }catch let error{
                    print("error when get customers")
                    complition(nil, error)
                }
            }
        }
    }
    
    func getAllProducts(complition: @escaping (Products?, Error?) -> Void) {
        guard let url = Url.shared.getAllProductsURL() else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
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
        URLSession.shared.dataTask(with: url) { data, response, error in
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
            guard let url = Url.shared.addAddress(id: "\(customerId)") else {return}
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            let session = URLSession.shared
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
        let customerId = ApplicationUserManger.shared.getUserID()
        guard let url = Url.shared.getAddressForCustomer(customerID: "\(customerId ?? 0)") else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
//                print(String(data: data, encoding: .utf8))
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
    
    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        guard let url = Url.shared.registerNewCustomer() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
            print(try! newCustomer.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func deleteAddressForCustomer(customerId: Int,id: Int, completion: @escaping  (Error?) -> ()) {
   //        let customer = CustomerAddress(addresses: [address])
   //        let Delete = DeleteAddress(customer: customer)
           guard let url = Url.shared.deleteAddress(customerID: "\(customerId)",id: "\(id)") else {return}
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let error = error {
                       completion(error)
                       return
                   }
                   completion(nil)
               }
           }
           task.resume()
       }
    

    func getOrdersForCustomer(customerId: Int, completion: @escaping (Customer?, Error?) -> Void) {
        let customerId = ApplicationUserManger.shared.getUserID()
        guard let url = Url.shared.getAddressForCustomer(customerID: "\(customerId ?? 0)") else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let data = data{
//                print(String(data: data, encoding: .utf8))
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
                        print(error.localizedDescription)
                    }
                }
            }

        }.resume()

    }

    
    
    func addOrder(order:OrderToAPI,completion: @escaping (Data?,URLResponse?,Error?)->Void){
        guard let url = Url.shared.ordersURL() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
            print(try! order.asDictionary())
        }catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request) { (data,response,error) in
            completion(data, response, error)
        }.resume()
    }
    
    func getDiscounts(priceRuleId: Int, complition: @escaping (DiscountModel?, Error?) -> Void) {
        guard let url = Url.shared.getDiscount(priceRuleId: "\(priceRuleId)") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(DiscountModel.self, from: data)
                    DispatchQueue.main.async{
                        complition(json, nil)
                        print("success to get all Coupouns")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print("error when get All Coupouns")
                        print(error)
                        complition(nil, error)

                    }
                }
            }
            if let error = error{

                print(error)
            }
        }.resume()
    }

    func deleteDiscount(priceRuleId: Int, discountCodeId: Int, completion: @escaping (Error?) -> ()) {
        guard let url = Url.shared.deleteDiscount(priceRuleId: "\(priceRuleId)", discountCodeId: "\(discountCodeId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    
}
