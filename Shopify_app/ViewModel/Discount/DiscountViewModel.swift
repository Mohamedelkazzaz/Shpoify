//
//  DiscountViewModel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 12/07/2022.
//

import Foundation


class DiscountViewModel {
    
    var discount: [DiscountCode]? {
        didSet {
            bindingData(discount,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    let apiService: ApiService
    var bindingData: (([DiscountCode]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func fetchDiscounts() {
        let priceRuleID = 1193587179734
        
        apiService.getDiscounts(priceRuleId: priceRuleID) { discount, error in
            if let discount = discount {
                self.discount = discount.discountCodes
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func getCoupuns() -> [DiscountCode]?{
        
        return discount
    }
    
    func getCoupon(indexPath: IndexPath) -> DiscountCode?{
        
        return discount?[indexPath.row]
    }
}
