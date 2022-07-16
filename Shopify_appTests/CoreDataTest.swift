//
//  CoreDataTest.swift
//  Shopify_appTests
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//

import XCTest
@testable import Shopify_app

class CoreDataTest: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    }

   
    
    func testCartCoreData(){
        let cart =  CoreDataManager.shared.fetchDataFromCart()
        XCTAssertNotNil(cart)
    }
    
    func testFavoritCoreData(){
        let Favorit =  CoreDataManager.shared.fetchDataFromFavorit()
        XCTAssertNotNil(Favorit)
    }

}
