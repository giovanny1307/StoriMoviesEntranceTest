//
//  MoviesRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

final class RemoteTopMoviesRepository: TopMoviesRepository {
    
    private let remoteDataSource: HttpClient
    
    init(remoteDataSource: HttpClient) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTopRatedMovies(from page: Int) async throws -> [Movie] {
        let (data, response) = try await remoteDataSource.request(MoviesEndpoint.getTopMoviesFrom(page: page).getUrlRequest())
        return try DataMapper.map(data: data, httpURLResponse: response).movies
    }
}
