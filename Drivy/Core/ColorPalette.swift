//
//  ColorPalette.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(rgbaValue: UInt32) {
        let red = CGFloat((rgbaValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbaValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbaValue & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// drivy blue
    static let drivyBlue = UIColor(rgbaValue: 0x22A3B9)
    
    /// drivy gray
    static let foodieGray = UIColor(rgbaValue: 0x9B9B9B)
}
