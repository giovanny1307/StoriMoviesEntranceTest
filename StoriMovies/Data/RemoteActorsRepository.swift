//
//  RemoteActorsRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

final class RemoteActorsRepository: ActorsRepository {
    
    private let remoteDataSource: HttpClient
    
    init(remoteDataSource: HttpClient) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getActors(for movieId: Int) async throws -> [Actor] {
        let (data, response) = try await remoteDataSource.request(MoviesEndpoint.getCrewForMovie(id: movieId).getUrlRequest())
        return try DataMapper.map(data: data, httpURLResponse: response)
    }
}
