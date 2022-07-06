//
//  AddressViewMopdel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 04/07/2022.
//

import Foundation


class AddressViewModel {
    
//    var 
    var address: [Address]? {
        didSet {
            bindingData(address,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: (([Address]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    func fetchAddreesesForCoustomer() {
        let customerId = ApplicationUserManger.shared.getUserID() ?? 0
        apiService.getAddressForCustomer(customerId: customerId) { address, error in
            if let address = address {
                self.address = address.addresses
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getAddreeses() -> [Address]?{
        return address
    }
    
    func getAddress(indexPath: IndexPath) -> Address?{
        return address?[indexPath.row]
    }
}
