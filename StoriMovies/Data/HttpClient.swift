//
//  HttpClient.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

protocol HttpClient {
    func request(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse)
}
