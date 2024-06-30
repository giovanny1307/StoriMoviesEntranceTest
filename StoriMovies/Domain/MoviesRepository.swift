//
//  MoviesInMemoryRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

protocol MoviesRepository {
    func getMovie(at index: Int) -> Movie
    func getMovieCount() -> Int
    func store(_ movies:[Movie])
}
