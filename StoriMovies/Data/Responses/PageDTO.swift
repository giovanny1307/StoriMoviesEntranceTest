//
//  PageDTO.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

struct PageDTO: Decodable {
    var page: Int
    var results: [MovieDTO]
    
    func mapToDomain() -> Page {
        Page(page: page, movies: results.map { dto in dto.mapToDomain() })
    }
}

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
    let vote_average: Double
    
    func mapToDomain() -> Movie {
        Movie(id: id,
              rating: vote_average,
              release_date: release_date,
              poster_url_string: poster_path,
              landscape_poster_url_string: backdrop_path,
              name: title,
              description: overview)
    }
}
