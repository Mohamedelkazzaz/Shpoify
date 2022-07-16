//
//  NetworkTest.swift
//  Shopify_appTests
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//


import XCTest
@testable import Shopify_app
class NetworkManagerTests: XCTestCase {

    
    var apiService: ApiService!
    
    override func setUp() {
        apiService = NetworkManagerMock(shouldReturnError: false)
    }
    override func tearDown() {
        apiService = nil
    }
    
    
    func testFetchingMockingData() {
        apiService.getAllCustomers { customers, error in
          //  XCTAssertNotNil(customers)
            XCTAssertEqual(customers?.customers.count ?? 0, 1)
        }

    }
    
   
    

 
}
