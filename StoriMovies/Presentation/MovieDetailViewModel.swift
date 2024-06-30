//
//  MovieDetailViewModel.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation
import Combine
import UIKit

final class MovieDetailViewModel {
    
    private let movie: Movie
    
    private let loadMovieSubject = PassthroughSubject<Movie, Never>()
    var moviePublisher: AnyPublisher<Movie,Never> {
        loadMovieSubject.eraseToAnyPublisher()
    }
    
    private let transferIdSubject = PassthroughSubject<Int, Never>()
    var actorsPublisher: AnyPublisher<Int,Never> {
        transferIdSubject.eraseToAnyPublisher()
    }
    
    private let rateSubject = PassthroughSubject<Void, Never>()
    var rateMoviePubliser: AnyPublisher<Void, Never> {
        rateSubject.eraseToAnyPublisher()
    }
    
    init(movie: Movie) {
        self.movie = movie }
    
    func loadMovie() {
        loadMovieSubject.send(movie)
    }
    
    func rateMovie() {
        rateSubject.send(())
    }
    
    func transferActorsId() {
        transferIdSubject.send(movie.id)
    }
}
