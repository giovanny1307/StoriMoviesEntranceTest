//
//  DataMapper.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 1/07/24.
//

import Foundation

final class DataMapper {
    
    struct InvalidHTTPStatusCode: Error {}
    static let RESPONSE_200_OK = 200
    
    static func map(data: Data, httpURLResponse: HTTPURLResponse) throws -> Page {
        if httpURLResponse.statusCode != RESPONSE_200_OK {
            throw InvalidHTTPStatusCode()
        }
        
        let decoded = try JSONDecoder().decode(PageDTO.self, from: data)
        
        return decoded.mapToDomain()
    }
    
    static func map(data: Data, httpURLResponse: HTTPURLResponse) throws -> [Actor] {
        if httpURLResponse.statusCode != RESPONSE_200_OK {
            throw InvalidHTTPStatusCode()
        }
        
        let decoded = try JSONDecoder().decode(CreditsDTO.self, from: data)
        
        return decoded.cast.map { $0.mapToDomain() }
    }
    
}

