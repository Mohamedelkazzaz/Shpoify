//
//  Cuurency.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 14/07/2022.
//

import Foundation

struct CurrencyModel: Codable {
//    let meta: Meta
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let egp: EGP

    enum CodingKeys: String, CodingKey {
        case egp = "EGP"
    }
}

// MARK: - Usd
struct EGP: Codable {
    let code: String
    let value: Double
}

// MARK: - Meta
//struct Meta: Codable {
//    let lastUpdatedAt: Date
//
//    enum CodingKeys: String, CodingKey {
//        case lastUpdatedAt = "last_updated_at"
//    }
//}

