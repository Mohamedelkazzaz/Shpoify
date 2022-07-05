//
//  addAddressCell.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 03/07/2022.
//

import UIKit

class addAddressCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(address: Address?){
        addressLabel.text = address?.address1 ?? ""
        countryLabel.text = address?.country ?? ""
        cityLabel.text = address?.city ?? ""
    }
}
