//
//  ActorsViewModel.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 5/07/24.
//

import Foundation
import Combine
import StoriMoviesUIComponents
import UIKit

@MainActor
final class ActorsViewModel {
    
    private var actors: [Actor] = []
    
    private let movieId: Int
    private let remoteRepository: ActorsRepository
    
    @Published private(set) var isLoading = false
    
    private let loadActorsSubject = PassthroughSubject<Void, Never>()
    var actorsPublisher: AnyPublisher<Void,Never> {
        loadActorsSubject.eraseToAnyPublisher()
    }
    
    private let errorSubject = PassthroughSubject<String, Never>()
    var errorPublisher: AnyPublisher<String,Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    init(remoteRepository: ActorsRepository,
         movieId: Int) {
        self.remoteRepository = remoteRepository
        self.movieId = movieId
    }
    
    func getActors() {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task { [weak self] in
            guard let self else { return }
    
            // added for simulating delay on request so spinner is able to be shown
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            do {
                let actors = try await self.remoteRepository.getActors(for: movieId)
                handleActors(actors)
            } catch {
                errorSubject.send("Couldn't process your request, please try again \(error.localizedDescription)")
            }
            
            isLoading = false
        }
    }
    
    func getActor(for indexPath: IndexPath) -> UserCardModel {
        let actor = actors[indexPath.row]
        
        return .init(actorName: actor.name,
                     characterName: actor.character_name,
                     photoUrl: "\(AppConstants.image_url)\(actor.picture_url_string ?? "")")
    }
    
    func getActorCount() -> Int {
        actors.count
    }
    
    private func handleActors(_ actors: [Actor]) {
        self.actors = actors
        loadActorsSubject.send()
    }
}
