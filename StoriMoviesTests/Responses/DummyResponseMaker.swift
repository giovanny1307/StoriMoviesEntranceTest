//
//  DummyResponseMaker.swift
//  StoriMoviesTests
//
//  Created by Giovanny Piñeros on 3/07/24.
//

import Foundation
@testable import StoriMovies

class DummyResponseMaker {
    
    static func makeTopMoviesData() -> Data {
        
        let jsonString = """
            {
              "page": 1,
              "results": [
                {
                  "adult": false,
                  "backdrop_path": "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
                  "genre_ids": [
                    18,
                    80
                  ],
                  "id": 278,
                  "original_language": "en",
                  "original_title": "The Shawshank Redemption",
                  "overview": "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                  "popularity": 159.594,
                  "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
                  "release_date": "1994-09-23",
                  "title": "The Shawshank Redemption",
                  "video": false,
                  "vote_average": 8.705,
                  "vote_count": 26395
                },
                {
                  "adult": false,
                  "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
                  "genre_ids": [
                    18,
                    80
                  ],
                  "id": 238,
                  "original_language": "en",
                  "original_title": "The Godfather",
                  "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
                  "popularity": 194.841,
                  "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                  "release_date": "1972-03-14",
                  "title": "The Godfather",
                  "video": false,
                  "vote_average": 8.693,
                  "vote_count": 20019
                } ]
            }
"""
        return Data(jsonString.utf8)
    }
    
    static func makeActorsData() -> Data {
        
        let jsonString = """
            {
              "id": 278,
              "cast": [
                {
                  "adult": false,
                  "gender": 2,
                  "id": 504,
                  "known_for_department": "Acting",
                  "name": "Tim Robbins",
                  "original_name": "Tim Robbins",
                  "popularity": 17.984,
                  "profile_path": "/djLVFETFTvPyVUdrd7aLVykobof.jpg",
                  "cast_id": 3,
                  "character": "Andy Dufresne",
                  "credit_id": "52fe4231c3a36847f800b131",
                  "order": 0
                },
                {
                  "adult": false,
                  "gender": 2,
                  "id": 192,
                  "known_for_department": "Acting",
                  "name": "Morgan Freeman",
                  "original_name": "Morgan Freeman",
                  "popularity": 95.93,
                  "profile_path": "/jPsLqiYGSofU4s6BjrxnefMfabb.jpg",
                  "cast_id": 4,
                  "character": "Ellis Boyd 'Red' Redding",
                  "credit_id": "52fe4231c3a36847f800b135",
                  "order": 1
                } ]
        }
"""
        return Data(jsonString.utf8)
    }
    
    static func makeInvalidData() -> Data {
        return Data("Invalid_data".utf8)
    }
    
    static func makeHTTPURLResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "gio-url.com")!,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: [:])!
    }
    
    static func makeDummyMovie() -> Movie {
        .init(id: 1,
              rating: 3.0,
              release_date: "20-12-2009",
              poster_url_string: "someurl.co",
              landscape_poster_url_string: "someurl.co",
              name: "The life of gio",
              description: "Gio is amazing")
    }
}
