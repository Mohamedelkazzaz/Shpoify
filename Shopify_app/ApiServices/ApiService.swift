//
//  ApiService.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 28/06/2022.
//

import Foundation

protocol ApiService{
    
    func getAllBrands(complition: @escaping (Brands?, Error?)->Void)
    func getAllProducts(complition: @escaping (Products?, Error?)->Void)
    func getProductsByCategory(collectionId:String,complition: @escaping (Products?, Error?)->Void)
    func addAddress(customerId: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->())
    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->())
    func getAllCustomers(complition: @escaping (Customers?, Error?)->Void)
}
