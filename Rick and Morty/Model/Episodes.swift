//
//  Episodes.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation

// MARK: - Episodes
struct Episodes: Codable {
    let info: Info
    let results: [Episode]
}

// MARK: - Info
struct EpisodesInfo: Codable {
    let count, pages: Int
    let next: String?

}

// MARK: - Result
struct Episode: Codable , Identifiable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
