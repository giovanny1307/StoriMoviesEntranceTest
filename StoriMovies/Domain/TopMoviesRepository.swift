//
//  MoviesRemoteRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

protocol TopMoviesRepository {
    func getTopRatedMovies(from page: Int) async throws -> [Movie]
}
