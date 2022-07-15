//
//  RegistarationTest.swift
//  Shopify_appTests
//
//  Created by Ahmed Hussien on 16/12/1443 AH.
//

import XCTest
@testable import Shopify_app

class RegistarationTest: XCTestCase {

    var apiService: ApiService!
    let registerViewModel = AuthenticationViewModel()
    
    
    override func setUp() {
        apiService = NetworkManager()
    }
    override func tearDown() {
        apiService = nil
    }
    
    func testRegisterNetworking(){
        let promise = expectation(description: "wating for  response")
        
        let customer = Customer(first_name: "hem", last_name: "a", email: "ibrahhim@gmail.com", phone:nil, tags: "123456", id: 6277923504342, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        apiService.register(newCustomer: newCustomer) { data, response, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(data)
                //XCTAssertNil(data)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testCreateNewCustomer(){
        let promise = expectation(description: "wating for  response")
        
        let customer = Customer(first_name: "Ahmed", last_name: "hussien", email: "ahmedhussien@gmail.com", phone: "01111111111", tags: "123456", id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        registerViewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(data)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testCheckUserIsExist(){
        let promise = expectation(description: "wating for response")
         registerViewModel.checkUserIsExist(email: "ahmedhussien@gmail.com") { userIsExist in
            if userIsExist{
                promise.fulfill()
            }else{
                XCTFail()
            }
             
        }
        wait(for: [promise], timeout: 5)
    }
}
