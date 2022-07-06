//
//  Customer.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 04/07/2022.
//

import Foundation

struct NewCustomer: Codable {
    let customer: Customer
}

struct Customers: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    let first_name, last_name, email, phone, tags: String?
    let id: Int?
    let verified_email: Bool?
    let addresses: [Address]?
}

struct Address: Codable {
    var address1, city, province, phone: String?
    var zip, last_name, first_name, country: String?
    var id: Int?
}

struct LoginResponse: Codable {
    let customers: [Customer]
}

struct CustomerAddress: Codable {
    var addresses: [Address]?
}

struct UpdateAddress: Codable {
    var address: Address
}

struct PutAddress: Codable {
    let customer: CustomerAddress?
}

struct DeleteAddress: Codable {
    let customer: CustomerAddress?
}
