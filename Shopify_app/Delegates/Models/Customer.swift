//
//  Customer.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 04/07/2022.
//

import Foundation

// MARK: - CustomerModel
struct CustomerModel: Codable {
    let customer: Customer
}

// MARK: - Customer
struct Customer: Codable {
    let id: Int
    let email: String
    let acceptsMarketing: Bool
    let createdAt, updatedAt: Date
    let firstName, lastName: String
    let ordersCount: Int
    let state, totalSpent: String
    let lastOrderID, note: String?
    let verifiedEmail: Bool
    let multipassIdentifier: String?
    let taxExempt: Bool
    let phone, tags: String
    let lastOrderName: String?
    let currency: String
    let addresses: [Address]
    let acceptsMarketingUpdatedAt: Date
    let marketingOptInLevel: String?
    let defaultAddress: Address

    enum CodingKeys: String, CodingKey {
        case id, email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case state
        case totalSpent = "total_spent"
        case lastOrderID = "last_order_id"
        case note
        case verifiedEmail = "verified_email"
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case phone, tags
        case lastOrderName = "last_order_name"
        case currency, addresses
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case marketingOptInLevel = "marketing_opt_in_level"
        case defaultAddress = "default_address"
    }
}

// MARK: - Address
struct Address: Codable {
    let id, customerID: Int
    let firstName, lastName: String
    let company: String?
    let address1: String
    let address2: String?
    let city, province, country, zip: String
    let phone, name, provinceCode, countryCode: String
    let countryName: String
    let addressDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case addressDefault = "default"
    }
    
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
