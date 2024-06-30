//
//  ActorsRepository.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

protocol ActorsRepository {
    func getActors(for movieId: Int) async throws -> [Actor]
}
