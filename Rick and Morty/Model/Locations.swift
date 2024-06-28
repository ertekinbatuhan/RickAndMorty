// Locations.swift

import Foundation

struct Locations: Codable {
    let info: Info
    let results: [LocationData] 

    // MARK: - Info
    struct Info: Codable {
        let count, pages: Int
        let next: String?
    }

    // MARK: - LocationData
    struct LocationData: Codable {
        let id: Int
        let name, type, dimension: String
        let residents: [String]
        let url: String
        let created: String
    }
}

