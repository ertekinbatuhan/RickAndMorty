//
//  LocationsViewModel.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations = [Locations.LocationData]()
    
    func fetchLocations(url: URL, completion: @escaping (Swift.Result<[Locations.LocationData], RickAndMortyError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Locations.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(.dataParseError))
            }
        }.resume()
    }
    
    func loadLocations() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else { return }
        
        fetchLocations(url: url) { result in
            switch result {
            case .success(let locations):
                DispatchQueue.main.async {
                    self.locations = locations
                }
            case .failure(let error):
                print("Error fetching location data: \(error.localizedDescription)")
            }
        }
    }
}

