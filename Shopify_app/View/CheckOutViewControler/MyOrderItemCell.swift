//
//  MyOrderItemCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 06/12/1443 AH.
//

import UIKit

class MyOrderItemCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var amoutLable: UILabel!
    func setupCell(cart: Cart?){
        priceLable.text = cart?.price
        amoutLable.text = "\(cart!.quantity)"
        
        let url = URL(string:(cart?.image)!)!
        if let data = try? Data(contentsOf: url) {
            itemImage.image = UIImage(data: data)
            itemImage.layer.cornerRadius = 25
        }
     

    }
}
