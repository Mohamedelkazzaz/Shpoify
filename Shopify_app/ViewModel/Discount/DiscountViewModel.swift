//
//  DiscountViewModel.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 12/07/2022.
//

import Foundation
import ProgressHUD


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
                for (index,element) in (self.discount ?? []).enumerated(){
                    let code = element.code.split(separator: "y").last
                    if let codePercentage = Int(code ?? ""){
                        self.discount?[index].discountPercentage = codePercentage
                    }
                    
                }
                
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    func applyCoupon(code: String, price: Double) -> Double {
       
        return price - (price * checkCouponCode(code: code))
    }
    
    private func checkCouponCode(code: String) -> Double {
        var discountAmount = 0.0
        if discount?.contains(where: { discountCode in
            if code == discountCode.code {
                discountAmount = Double(discountCode.discountPercentage ?? 0)
            }
            return  code == discountCode.code
        }) ?? false {
            ProgressHUD.showSucceed("Valid Coupon", interaction: true)
            return discountAmount/100
        }
        ProgressHUD.showFailed("Invalid Code", interaction: true)
        return discountAmount/100
        
    }
    
    func getCoupuns() -> [DiscountCode]?{
        
        return discount
    }
    
    func getCoupon(indexPath: IndexPath) -> DiscountCode?{
        
        return discount?[indexPath.row]
    }
}
