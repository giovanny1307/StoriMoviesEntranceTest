//
//  RemoteActorsRepositoryTests.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import Foundation

@testable import StoriMovies
import XCTest

class RemoteActorsRepositoryTests: XCTestCase {
    
    var remoteRepository: RemoteActorsRepository!
    var httpClient: HttpClientMock!
    
    override func setUp() {
        super.setUp()
        (remoteRepository, httpClient) = makeSUT()
    }
    
    override func tearDown() {
        super.tearDown()
        (remoteRepository, httpClient) = (nil, nil)
    }
    
    func test_getActors_when_validData_and_validResponse_should_getActors() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeActorsData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 200)), nil)
        
        do {
            let actors = try await remoteRepository.getActors(for: 278)
            
            XCTAssertEqual(2, actors.count)
            XCTAssertEqual(1, httpClient.requests.count)
            
            if let pathComponents =  httpClient.requests[0].url?.pathComponents {
                XCTAssertTrue(pathComponents.contains("278"))
            } else {
                XCTFail("Bad composed URL")
            }
            
        } catch {
            XCTFail("Expected success got \(error) instead")
        }
    }
    
    func test_getActors_when_inValidData_andValidResponse_should_not_getMovies() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeInvalidData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 200)), nil)
        
        do {
            _ = try await remoteRepository.getActors(for: 1)
            XCTFail("Expected error got success instead")
            
        } catch {
            XCTAssertEqual(1, httpClient.requests.count)
        }
    }
    
    func test_getActors_wheh_inValidData_and_inValidResponse_should_not_getMovies() async {
        
        httpClient.requestResponse = ((DummyResponseMaker.makeInvalidData(),
                                       DummyResponseMaker.makeHTTPURLResponse(statusCode: 404)), nil)
        
        do {
            _ = try await remoteRepository.getActors(for: 1)
            XCTFail("Expected error got success instead")
            
        } catch {
            XCTAssertEqual(1, httpClient.requests.count)
        }
    }
    
    
}

extension RemoteActorsRepositoryTests {
    
    func makeSUT() -> (RemoteActorsRepository, HttpClientMock) {
        let httpClient = HttpClientMock()
        let repository = RemoteActorsRepository(remoteDataSource: httpClient)
        
        return(repository, httpClient)
    }
}
