//
//  TopMoviesViewModel.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation
import Combine
import StoriMoviesUIComponents
import UIKit

@MainActor
final class TopMoviesViewModel {
    
    private let moviesRepository: TopMoviesRepository
    private let localMoviesRepository: MoviesRepository
    
    private var page: Int = 0
    
    @Published private(set) var isLoading = false
    
    private let selectionSubject = PassthroughSubject<Movie, Never>()
    var selectionPublisher: AnyPublisher<Movie, Never> {
        selectionSubject.eraseToAnyPublisher()
    }
    
    private let loadMoviesSubject = PassthroughSubject<Void, Never>()
    var moviesPublisher: AnyPublisher<Void,Never> {
        loadMoviesSubject.eraseToAnyPublisher()
    }
    
    private let errorSubject = PassthroughSubject<String, Never>()
    var errorPublisher: AnyPublisher<String,Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    init(remoteRepository: TopMoviesRepository,
         localRepository: MoviesRepository) {
        self.moviesRepository = remoteRepository
        self.localMoviesRepository = localRepository
    }
    
    func getTopRatedMovies() {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task { [weak self] in
            guard let self else { return }
            
            // added for simulating delay on request so spinner is able to be shown
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            do {
                let movies = try await self.moviesRepository.getTopRatedMovies(from: nextPage())
                handleMovies(movies)
                
            } catch {
                errorSubject.send("Couldn't process your request, please try again")
            }
            
            isLoading = false
        }
    }
    
    func shouldGetMoreMovies(_ row: Int) {
        if row == getMovieCount() - 1 {
            getTopRatedMovies()
        }
    }
    
    func getMovie(for indexPath: IndexPath) -> MovieRankingCellModel {
        let movie = getMovie(at: indexPath.row)
        
        return MovieRankingCellModel(headerModel: .init(ranking: String(indexPath.row + 1),
                                                        movieName: movie.name,
                                                        movieReleaseDate: movie.release_date,
                                                        moviePosterUrl: "\(AppConstants.image_url)\(movie.landscape_poster_url_string)"))
    }
    
    func getMovieSelected(at indexPath: IndexPath) {
        selectionSubject.send(getMovie(at: indexPath.row))
    }
    
    func getMovieCount() -> Int {
        localMoviesRepository.getMovieCount()
    }
    
    private func getMovie(at index: Int) -> Movie {
        localMoviesRepository.getMovie(at: index)
    }
    
    private func handleMovies(_ movies: [Movie]) {
        localMoviesRepository.store(movies)
        loadMoviesSubject.send()
    }
    
    private func nextPage() -> Int {
        page += 1
        return page
    }
}
