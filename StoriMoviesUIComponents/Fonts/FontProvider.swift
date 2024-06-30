//
//  FontProvider.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import UIKit

public class FontProvider: FontProviderProtocol {
    
    public static func getFont(of type: StoriMoviesFont,
                               with size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name,
                                size: size) else {
            return UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: size))
        }
        
        return UIFontMetrics.default.scaledFont(for: font)
    }
}
