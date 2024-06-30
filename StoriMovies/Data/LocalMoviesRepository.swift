//
//  LocalMoviesRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

final class LocalMoviesRepository: MoviesRepository {
    
    private var localMoviesStorage: [Movie] = []
    
    func getMovie(at index: Int) -> Movie {
        localMoviesStorage[index]
    }
    
    func getMovieCount() -> Int {
        localMoviesStorage.count
    }
    
    func store(_ movies: [Movie]) {
        localMoviesStorage.append(contentsOf: movies)
    }
    
}
