//
//  UIColor+Extensions.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import UIKit

extension UIColor {
    
    /// This convenience init allows you to add hex colors with hexadecimal notation. Simple add 0x at the beggining of the hex color code.
    ///  Replace the #FFFFFF for 0xFFFFFFFF
    /// - Parameter rgb: 0XFFFFFF
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    fileprivate convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
