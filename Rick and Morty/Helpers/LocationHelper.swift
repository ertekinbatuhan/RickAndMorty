//
//  LocationHelper.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation

class LocationHelper {
    
    static func filteredLocations(locations: [Locations.LocationData], searchText: String) -> [Locations.LocationData] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
}
