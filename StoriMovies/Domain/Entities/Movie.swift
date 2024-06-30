//
//  Movie.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

struct Movie: Hashable, Equatable {
    let id: Int
    let rating: Double
    let release_date: String
    let poster_url_string: String
    let landscape_poster_url_string: String
    let name: String
    let description: String
}
