//
//  ProductCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    func configureCell(productName: String, productImage: String, productPrice:String) {
        self.productName.text = productName
//        ConvertPrice.getPrice(price: Double(productPrice ?? "") ?? 0.0)
        self.productPrice.text = "\(ConvertPrice.getPrice(price: Double(productPrice ?? "") ?? 0.0))"
        
        let url = URL(string:productImage)
        if let data = try? Data(contentsOf: url!) {
            self.productImage.image = UIImage(data: data)
        }
    }
}
