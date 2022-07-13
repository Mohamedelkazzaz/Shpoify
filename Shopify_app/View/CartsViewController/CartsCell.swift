//
//  CartsCell.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 01/07/2022.
//

import UIKit
import SDWebImage

class CartsCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityNumberLabel: UILabel!
    
 
    var addItemQuantity : (()->())?
    var subItemQuantity : (()->())?
    
    @IBAction func addToFavouriteButton(_ sender: UIButton) {
    }
    @IBAction func deleteItemButton(_ sender: UIButton) {
    }
    @IBAction func minusQuantityButton(_ sender: Any) {
        subItemQuantity?()
    }
    @IBAction func plusQuantityButton(_ sender: UIButton) {
        addItemQuantity?()
    }
    
    func setup(cart: Cart?){
        priceLabel.text = cart?.price
        quantityNumberLabel.text = "\(cart?.quantity ?? 0)"
        itemImage.sd_setImage(with: URL(string: cart?.image ?? ""), completed: nil)
        itemNameLabel.text = cart?.title
    }
}


