//
//  StoriMoviesFont.swift
//  StoriMoviesUIComponents
//
//  Created by Giovanny Piñeros on 30/06/24.
//

import Foundation

public enum StoriMoviesFont: String {
    case rubikMainTitle = "Rubik-ExtraBold"
    case rubikTitle = "Rubik-Bold"
    case rubikSubTitle = "Rubik-SemiBold"
    case rubikContentHeader = "Rubik-Medium"
    case rubikContentSubHeader = "Rubik-Regular"
    case rubikContent = "Rubik-Light"
    
    var name: String {
        return self.rawValue
    }
}
