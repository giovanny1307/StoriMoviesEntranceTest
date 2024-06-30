//
//  FontProviderProtocol.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import UIKit

public protocol FontProviderProtocol {
    static func getFont(of type: StoriMoviesFont,
                        with size: CGFloat) -> UIFont
}
