//
//  LocalMoviesRepositoryTests.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

@testable import StoriMovies
import XCTest

class LocalMoviesRepositoryTests: XCTestCase {
    
    var localRepository: LocalMoviesRepository!
    
    override func setUp() {
        super.setUp()
        localRepository = makeSUT()
    }
    
    override func tearDown() {
        super.tearDown()
        localRepository = nil
    }
    
    func test_when_movieStored_count_shoul_notBeZero() {
        let movie = DummyResponseMaker.makeDummyMovie()
        
        localRepository.store([movie])
        
        XCTAssertNotEqual(0, localRepository.getMovieCount())
    }
    
    func test_when_movieStored_shoul_get_movieAtIndex() {
        let movie = DummyResponseMaker.makeDummyMovie()
        
        localRepository.store([movie])
        
        XCTAssertNotNil(localRepository.getMovie(at: 0))
    }
}


extension LocalMoviesRepositoryTests {
    
    func makeSUT() -> LocalMoviesRepository{
        let repository = LocalMoviesRepository()
        
        return repository
    }
}

