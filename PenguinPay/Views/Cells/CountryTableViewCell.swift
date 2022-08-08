//
//  CountryTableViewCell.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak private var countryLabel: UILabel!
    @IBOutlet weak private var countryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: CountryInformation?) {
        guard let data = data else {
            return
        }
        countryCodeLabel.text = data.phonePrefix
        countryLabel.text = data.country
        countryImageView.image = UIImage(named: data.image ?? "")
    }
}
