//
//  RemoteTopMoviesRepositoryMock.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import Foundation
@testable import StoriMovies

class RemoteTopMoviesRepositoryMock: TopMoviesRepository {
    
    var response: [Movie]?
  
    func getTopRatedMovies(from page: Int) async throws -> [Movie] {
        if let movies = response {
            return movies
        } else {
            throw NSError(domain: "Failed remote", code: 400)
        }
    }
    
}
