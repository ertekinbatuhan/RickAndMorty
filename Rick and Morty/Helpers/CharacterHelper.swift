//
//  CharacterHelper.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation


class CharacterHelper {
    
    static func filteredResults(results: [Result], search: String) -> [Result] {
        if search.isEmpty {
            return results
        } else {
            return results.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
    }
    
}
