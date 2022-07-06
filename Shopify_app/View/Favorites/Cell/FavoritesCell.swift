//
//  FavoritesCell.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(favorites: Favorites)  {
        
        let cellProductImage = favorites.productImage ?? ""
        let cellProductName = favorites.productName
        let cellProductPrice = favorites.productPrice
        let dataDecoding: Data = Data(base64Encoded: cellProductImage, options: .ignoreUnknownCharacters)!
        let datadecoded = UIImage(data: dataDecoding)
        productImage!.image = datadecoded
        productPrice?.text = cellProductPrice
        productName?.text = cellProductName
        
    }
    
}
