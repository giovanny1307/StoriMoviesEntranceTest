//
//  LocalMoviesRepositoryMock.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import Foundation
@testable import StoriMovies

class LocalMoviesRepositoryMock: MoviesRepository {
    
    var localStorage: [Movie] = []
    
    func getMovie(at index: Int) -> Movie {
        localStorage[index]
    }
    
    func store(_ movies: [Movie]) {
        localStorage.append(contentsOf: movies)
    }
    
    func getMovieCount() -> Int {
        localStorage.count
    }
}
