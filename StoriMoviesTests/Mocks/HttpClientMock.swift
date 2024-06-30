//
//  HttpClientMock.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

@testable import StoriMovies
import Foundation

class HttpClientMock: HttpClient {
    private (set) var requests = [URLRequest]()
    var requestResponse: (response: (Data, HTTPURLResponse)?, error: Error?)?
    
    func request(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        requests.append(urlRequest)

        if let error = requestResponse?.error {
            throw error
        } else if let data = requestResponse?.response?.0, let response = requestResponse?.response?.1 {
            return (data, response)
        }
        
        throw NSError(domain: "Mocked response was not setted", code: 404)
    }
    
}
