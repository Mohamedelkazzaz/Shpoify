//
//  CartsCell.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 01/07/2022.
//

import UIKit

class CartsCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addToFavouriteButton(_ sender: UIButton) {
    }
    @IBAction func deleteItemButton(_ sender: UIButton) {
    }
    @IBAction func minusQuantityButton(_ sender: Any) {
    }
    @IBAction func plusQuantityButton(_ sender: UIButton) {
    }
    
}
