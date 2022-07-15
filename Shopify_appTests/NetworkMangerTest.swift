//
//  NetworkMangerTest.swift
//  Shopify_appTests
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//

import XCTest
@testable import Shopify_app
class NetworkMangerTest: XCTestCase {

    var apiService: ApiService!
    
    override func setUp() {
        apiService = NetworkManager()
    }
    override func tearDown() {
        apiService = nil
    }
    
    func testGetAllCustomers() {
        let promise = expectation(description: "wait for data")
        apiService.getAllCustomers { customers, error in
            if let error = error {
                XCTFail()
                print(error.localizedDescription)
            }else{
                XCTAssertNotNil(customers)
                promise.fulfill()
            }
        }
        //waitForExpectations(timeout: 5, handler: nil)
        wait(for: [promise], timeout: 5)
    }
    
    func testGetAllProducts(){
        let promise = expectation(description: "wait for data")
        apiService.getAllProducts { products, error in
            if let error = error {
                XCTFail()
                print(error.localizedDescription)
            }else{
                XCTAssertNotNil(products)
                promise.fulfill()
            }
        }
        //waitForExpectations(timeout: 5, handler: nil)
        wait(for: [promise], timeout: 5)
    }
    
    func testGetAllBrands(){
        let promise = expectation(description: "wait for data")
        apiService.getAllBrands { brands, error in
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(brands)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
}
