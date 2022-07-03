//
//  CollectionViewCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 01/12/1443 AH.
//

import UIKit

class BrandCell: UICollectionViewCell {
    
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    
    func configureCell(brandName: String, brandImage: String) {
        self.brandName.text = brandName
        let url = URL(string:brandImage)
        if let data = try? Data(contentsOf: url!) {
            self.brandImage.image = UIImage(data: data)
        }
        
       
    }
}
