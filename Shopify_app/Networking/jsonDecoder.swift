//
//  jsonDecoder.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//

import Foundation


func convertFromJson<T: Codable>(data: Data) -> T? {
    let jsonDecoder = JSONDecoder()
    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
    return decodedArray
}
