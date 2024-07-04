//
//  CreditsDTO.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

struct CreditsDTO:Decodable {
    let id: Int
    let cast: [CastDTO]
}

struct CastDTO:Decodable {
    let id: Int
    let name: String
    let profile_path: String
    let character: String
    
    func mapToDomain() -> Actor {
        Actor(name: name,
              character_name: character,
              picture_url_string: profile_path)
    }
}
