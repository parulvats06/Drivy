//
//  CarTableViewCell.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit
import SDWebImage

class CarTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var carImageContainerView: UIView! {
        didSet {
            carImageContainerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var carImageView: UIImageView! 
    @IBOutlet weak var starView: StarsView!
    @IBOutlet weak var pricePerDayLabel: UILabel! {
        didSet {
            pricePerDayLabel.font = Fonts.regular(.small)
        }
    }
    
    @IBOutlet weak var brandNameLabel: UILabel! {
        didSet {
            brandNameLabel.font = Fonts.condensed(.medium)
        }
    }
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func configure(model: Car) {
        carImageView.sd_setImage(with: URL( string: model.pictureUrl), completed: nil)
        pricePerDayLabel.text = pricePerDayText(model.pricePerDay)
       
        brandNameLabel.text = model.brand
        starView.configure(rating: model.rating)
    }
    
    fileprivate func pricePerDayText(_ price: Double) -> String {
        // add currency conversion
        guard let symbol = Utilities.getSymbolForCurrencyCode(code: Constants.Defaults.currencyCode) else {
            return ""
        }
        return symbol + " " + price.decimalFormatter(countryCode: Constants.Defaults.country) + "\n per day"
    }
}

