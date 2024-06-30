//
//  CreditsDTO.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

struct CreditsDTO:Decodable {
    var id: Int
    var cast: [CastDTO]
}

struct CastDTO:Decodable {
    var name: String
    var profile_path: String
    var character: String
    
    func mapToDomain() -> Actor {
        Actor(name: name,
              character_name: character,
              picture_url_string: profile_path)
    }
}
