//
//  CreditsDTO.swift
//  StoriMovies
//
//  Created by Giovanny Piñeros on 2/07/24.
//

import Foundation

struct CreditsDTO: Codable {
    let id: Int
    let cast: [CastDTO]
    let crew: [CrewMember]
}

struct CastDTO: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character: String
    let creditID: String
    let order: Int
    
    func mapToDomain() -> Actor {
        Actor(name: name,
              character_name: character,
              picture_url_string: profilePath)
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

struct CrewMember: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditID: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department
        case job
    }
}
