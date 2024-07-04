//
//  API.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

enum MoviesEndpoint {
    private static let baseURL = URL(string: AppConstants.server_url)!
    private static let headerFields = [ "accept": "application/json",
                                        "Authorization": "Bearer \(AppConstants.read_access_key)" ]
    
    case getTopMoviesFrom(page: Int)
    case getCrewForMovie(id: Int)
    
    func getUrlRequest() throws -> URLRequest {
        
        switch self {
        case .getTopMoviesFrom(let page):
            let pathURL = MoviesEndpoint.baseURL.appendingPathComponent("/movie/top_rated")
            var components = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "language", value: "en-US"),
              URLQueryItem(name: "page", value: String(page)),
            ]
            
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 20
            request.allHTTPHeaderFields = MoviesEndpoint.headerFields
            
            return request
        case .getCrewForMovie(let id):
            let pathURL = MoviesEndpoint.baseURL.appendingPathComponent("movie/\(id)/credits")
            var components = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "language", value: "en-US"),
            ]
            
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = MoviesEndpoint.headerFields
            
            return request
        }
        
    }
}
