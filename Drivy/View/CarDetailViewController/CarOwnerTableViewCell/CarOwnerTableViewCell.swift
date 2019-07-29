//
//  CarOwnerTableViewCell.swift
//  Drivy
//
//  Created by parul vats on 29/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit
import SDWebImage

class CarOwnerTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var starsView: StarsView! {
        didSet {
            starsView.hideRatingCount = true
        }
    }
    @IBOutlet weak var ownerNameLabel: UILabel! {
        didSet {
            ownerNameLabel.font = Fonts.regular(.medium)
        }
    }
    @IBOutlet weak var ownerHeaderLabel: UILabel! {
        didSet {
            ownerHeaderLabel.text = "Owner"
            ownerHeaderLabel.font = Fonts.condensed(.medium)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(modelItem: CarDetailViewModeltem) {
        guard let model = modelItem as? CarViewModelOwnerItem else {
            return
        }
        ownerImageView.sd_setImage(with: URL(string: model.ownerImageUrl), completed: nil)
        ownerNameLabel.text = model.name
        starsView.configure(rating: model.rating)
    }
}
