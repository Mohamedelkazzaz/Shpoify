//
//  MyOrdersDetailsCell.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 15/12/1443 AH.
//

import UIKit

class MyOrdersDetailsCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quntity: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
