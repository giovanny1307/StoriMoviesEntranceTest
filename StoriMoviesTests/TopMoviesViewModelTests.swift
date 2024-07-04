//
//  TopMoviesViewModelTests.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import Foundation
import Combine
@testable import StoriMovies
import XCTest

@MainActor
class TopMoviesViewModelTests: XCTestCase {
    
    private var subscription = Set<AnyCancellable>()
    
    var remoteRepository: RemoteTopMoviesRepositoryMock!
    var localRepository: LocalMoviesRepositoryMock!
    var viewModel: TopMoviesViewModel!
    
    var isLoading = false
    var reloadData = false
    var selectedMovie: Movie?
    var stringError: String?
    
    override func setUp() {
        super.setUp()
        (viewModel,remoteRepository, localRepository) = makeSUT()
        
        bind()
    }
    
    override func tearDown() {
        super.tearDown()
        (viewModel,remoteRepository, localRepository) = (nil, nil, nil)
    }
    
    func test_getTopRatedMovies_when_validData_should_reloadData() {
        
        var subscription = Set<AnyCancellable>()
        
        remoteRepository.response = [DummyResponseMaker.makeDummyMovie()]
        
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
      
        viewModel.getTopRatedMovies()
        
        XCTAssertTrue(isLoading)
        
        viewModel.moviesPublisher.sink {
            expectation.fulfill()
        }.store(in: &subscription)
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertEqual(1, viewModel.getMovieCount())
        XCTAssertFalse(isLoading)
        XCTAssertTrue(reloadData)
    }
    
}

extension TopMoviesViewModelTests {
    
    func makeSUT() -> (TopMoviesViewModel, RemoteTopMoviesRepositoryMock, LocalMoviesRepositoryMock) {
        let repository = RemoteTopMoviesRepositoryMock()
        let localRepository = LocalMoviesRepositoryMock()
        let viewModel = TopMoviesViewModel(remoteRepository: repository,
                                           localRepository: localRepository)
        
        return (viewModel, repository, localRepository)
    }
    
    func bind() {
        viewModel.$isLoading.sink { [unowned self] loading in
            isLoading = loading
        }.store(in: &subscription)
        
        viewModel?.selectionPublisher.sink(receiveValue: { [unowned self] movie in
            self.selectedMovie = movie
        }).store(in: &subscription)
        
        viewModel?.moviesPublisher.sink { [unowned self] in
            reloadData = true
        }.store(in: &subscription)
        
        viewModel?.errorPublisher.sink(receiveValue: {  [unowned self] error in
           stringError = error
        }).store(in: &subscription)
    }
}
