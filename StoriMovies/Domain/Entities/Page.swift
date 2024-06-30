//
//  Page.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

struct Page: Hashable, Equatable {
    var page: Int
    var movies: [Movie]
}
