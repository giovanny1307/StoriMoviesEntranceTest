//
//  MoviesRepositoryTest.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

@testable import StoriMovies
import XCTest

class RemoteTopMoviesRepositoryTest: XCTestCase {
    
    var remoteRepository: RemoteTopMoviesRepository!
    var httpClient: HttpClientMock!
    
    override func setUp() {
        super.setUp()
        (remoteRepository, httpClient) = makeSUT()
    }
    
    override func tearDown() {
        super.tearDown()
        (remoteRepository, httpClient) = (nil, nil)
    }
    
    func test_getTopRatedMovies_when_validData_and_validResponse_should_getMovies() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeTopMoviesData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 200)), nil)
        
        do {
            let movies = try await remoteRepository.getTopRatedMovies(from: 1)
            
            XCTAssertEqual(2, movies.count)
            XCTAssertEqual(1, httpClient.requests.count)
            
            guard let components = URLComponents(string: httpClient.requests[0].url?.absoluteString ?? ""),
                  let pageComponent = components.queryItems?.first(where: {$0.name == "page" }) else {
                XCTFail("URL was composed wrong")
                return
            }
            
            XCTAssertEqual(pageComponent.value, "1")
            
        } catch {
            XCTFail("Expected success got \(error) instead")
        }
    }
    
    func test_getTopRatedMovies_when_inValidData_andValidResponse_should_not_getMovies() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeInvalidData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 200)), nil)
        
        do {
            let movies = try await remoteRepository.getTopRatedMovies(from: 1)
            XCTFail("Expected error got success instead")
            
        } catch {
            XCTAssertEqual(1, httpClient.requests.count)
        }
    }
    
    func test_getTopRatedMovies_wheh_inValidData_and_inValidResponse_should_not_getMovies() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeInvalidData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 404)), nil)
        
        do {
            let movies = try await remoteRepository.getTopRatedMovies(from: 1)
            XCTFail("Expected error got success instead")
            
        } catch {
            XCTAssertEqual(1, httpClient.requests.count)
        }
    }
    
    
}

extension RemoteTopMoviesRepositoryTest {
    
    func makeSUT() -> (RemoteTopMoviesRepository, HttpClientMock) {
        let httpClient = HttpClientMock()
        let repository = RemoteTopMoviesRepository(remoteDataSource: httpClient)
        
        return(repository, httpClient)
    }
}




