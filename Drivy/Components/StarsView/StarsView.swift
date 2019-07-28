//
//  StarsView.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import UIKit
@IBDesignable
class StarsView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var ratingCountLabel: UILabel! {
        didSet {
            ratingCountLabel.font = Fonts.regular(.xSmall)
            ratingCountLabel.textColor = .drivyBlue
        }
    }
    
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    
    // MARK: - Variables
    private let fullStarImage:  UIImage = UIImage(named: "fullStar")!
    private let halfStarImage:  UIImage = UIImage(named: "halfStar")!
    private let emptyStarImage: UIImage = UIImage(named: "emptyStar")!
    
    @IBInspectable
    var hideRatingCount: Bool = false {
        didSet {
            ratingCountLabel.isHidden = true
        }
    }
    
    // MARK: - init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    internal func getStarImage(_ starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 0.5 == starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
    
    func configure(rating: Rating) {
        ratingCountLabel.text = String(rating.count)
        
        for (index, imageView) in [firstStarImageView, secondStarImageView, thirdStarImageView, fourthStarImageView, fifthStarImageView].enumerated() {
            imageView?.image = getStarImage(Double(index + 1), forRating: rating.average)
        }
    }
}
