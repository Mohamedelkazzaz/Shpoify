//
//  ProductCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 02/12/1443 AH.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    func configureCell(productName: String, productImage: String, productPrice:String) {
        self.productName.text = productName
        self.productPrice.text = productPrice
        let url = URL(string:productImage)
        if let data = try? Data(contentsOf: url!) {
            self.productImage.image = UIImage(data: data)
        }
    }
}
