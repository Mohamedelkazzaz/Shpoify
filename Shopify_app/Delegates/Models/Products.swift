//
//  Products.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 01/12/1443 AH.
//

import Foundation


struct Products: Codable {
    let products: [Product]?
}

struct Product: Codable {
    let id: Int?
    let title, bodyHTML, vendor: String?

    let product_type: String?

    let productType: String?

    let createdAt: Date?
    let handle: String?
    let updatedAt, publishedAt: Date?
    let templateSuffix: String?
    let status: String?
    let publishedScope: String?
    let tags, adminGraphqlAPIID: String?
    let variants: [Variant]?
    let options: [Option]?
    let images: [image]?
    let image: image?
}

struct image: Codable {
    let id, productID, position: Int?
    let createdAt, updatedAt: String?
    let alt: String?
    let width, height: Int?
    let src: String?
    let variantIDS: [String]?
    let adminGraphqlAPIID: String?

}
struct Variant: Codable {
    let id, productID: Int?
    let title, price, sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt, updatedAt: Date?
    let taxable: Bool?
    let barcode: String?
    let grams: Int?
    let imageID: String?
    let weight: Int?
    let weightUnit: String?
    let inventoryItemID, inventoryQuantity, oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlAPIID: String?
}

struct Option: Codable {
    let id, productID: Int?
    let name: String?
    let position: Int?
    let values: [String]?

}


