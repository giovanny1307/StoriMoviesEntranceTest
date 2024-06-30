//
//  ViewControllerCreator.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation
import UIKit

@MainActor
enum ViewControllerCreator{
    case topRatedMovies
    case movieDetail(movie: Movie)
    case actorsList(movieId: Int)
    
    func createViewController() -> UIViewController {
        switch self {
        case .topRatedMovies:
            let urlSessionClient = URLSessionHttpClient(urlSession: .shared)
            let remoteRepository = RemoteTopMoviesRepository(remoteDataSource: urlSessionClient)
            let localRepository = LocalMoviesRepository()
            let viewModel = TopMoviesViewModel(remoteRepository: remoteRepository,
                                        localRepository: localRepository)
            let viewController = TopMoviesTableViewController(style: .plain)
            viewController.viewModel = viewModel
            
            return viewController
        case .movieDetail(let movie):
            let viewModel = MovieDetailViewModel(movie: movie)
            let viewController = MovieDetailViewController()
            viewController.viewModel = viewModel
            
            return viewController
        default:
            return UIViewController()
        }
    }
}




