//
//  URLSessionHttpClient.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

final class URLSessionHttpClient: HttpClient {
    struct InvalidResponse: Error { }
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw InvalidResponse()
        }
        return (data, httpURLResponse)
    }
}
