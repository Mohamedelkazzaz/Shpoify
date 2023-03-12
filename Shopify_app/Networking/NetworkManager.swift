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
    
    func getAll<T:Codable>(url:URL?,modelType: T.Type, complition: @escaping Handler<T>) {
        guard let url = url else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(modelType.self, from: data)
                    DispatchQueue.main.async{
                        complition(json, nil)
                        print("success to get all Data")
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print("error when get All data")
                        complition(nil, error)
                    }
                }
            }
            if let error = error{
                print(error.localizedDescription)
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
    
    func addAddress(customerId: Int, address: Address, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()) {
        let customer = CustomerAddress(addresses: [address])
        let putObject = PutAddress(customer: customer)
        guard let url = Url.shared.addAddress(id: "\(customerId)") else {return}
        AF.request(url,method: .put,parameters: putObject).responseData{response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                            print("Error: Could print JSON in String")
                                            return
                                        }
                    print("prettyJsonData = \(prettyPrintedJson)")
                    completion(response.data,response.response,response.error)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
        
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
    

    func getOrdersForCustomer(customerId: Int, completion: @escaping (OrdersFromAPI?, Error?) -> Void) {
        let customerId = ApplicationUserManger.shared.getUserID()
        guard let url = Url.shared.getOrdersUser(customerId: customerId ?? 0) else {return}
        
        do {
            let data = try Data(contentsOf: url)
            do {
                let json = try JSONDecoder().decode(OrdersFromAPI.self, from: data)
                DispatchQueue.main.async
                {
                    completion(json,nil)
                }
                
            } catch let jsonError {
                DispatchQueue.main.async
                {
                    completion(nil,jsonError)
                }
            }

        } catch let urlError {
            DispatchQueue.main.async
            {
                completion(nil,urlError)
            }
        }
        
//        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
//            if let data = data{
//                do{
//                    let json = try JSONDecoder().decode(OrdersFromAPI.self, from: data)
//                    DispatchQueue.main.async{
//                        completion(json, nil)
//                        print("success to get all Addreeses")
//                    }
//                }catch let error{
//                    DispatchQueue.main.async{
//                        print(error)
//                        completion(nil, error)
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//        }.resume()

    }

    
    
    func addOrder(order:OrderToAPI,completion: @escaping (Data?,URLResponse?,Error?)->Void){
       // print("line 223  network \(order.order.current_total_price)")
        guard let url = Url.shared.ordersURL() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
         //   print("line 232  network \(order.order.current_total_price)")
        }catch let error {
            print(error)
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
    
    
    func getCurrency() {
        guard let url = Url.shared.getCurrency() else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data{
                do{
                    let json = try JSONDecoder().decode(CurrencyModel.self, from: data)
                    DispatchQueue.main.async{
//                        complition(json, nil)
                        print("success to get all brands")
                        ApplicationUserManger.shared.setCurrency(currency: json.data.egp.value)
                    }
                }catch let error{
                    DispatchQueue.main.async{
                        print(error)
//                        complition(nil, error)
                    }
                }
            }
            if let error = error{
                print(error.localizedDescription)
            }
        }.resume()
    }

}
