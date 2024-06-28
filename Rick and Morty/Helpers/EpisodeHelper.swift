//
//  EpisodeHelper.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation

class EpisodeHelper {
    
    static func filteredEpisodes(episodes: [Episode], searchText: String) -> [Episode] {
        if searchText.isEmpty {
            return episodes
        } else {
            return episodes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}
