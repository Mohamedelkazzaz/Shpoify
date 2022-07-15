//
//  MyOrderCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 15/12/1443 AH.
//

import UIKit

class MyOrderCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var stat: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
