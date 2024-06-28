//
//  EpisodesViewModel.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import Foundation

class EpisodesViewModel  : ObservableObject {
    
    @Published var episodes = [Episode]()
    
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func fetchEpisodes(url: URL, completion: @escaping (Swift.Result<[Episode], RickAndMortyError>) -> Void) {
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
                 let decodedData = try JSONDecoder().decode(Episodes.self, from: data)
                 completion(.success(decodedData.results))
             } catch {
                 completion(.failure(.dataParseError))
             }
         }.resume()
     }
    
    func loadEpisodes() {
        guard let url = URL(string: "\(baseURL)episode") else { return }
           
           fetchEpisodes(url: url) { result in
               switch result {
               case .success(let episodes):
                   DispatchQueue.main.async {
                       self.episodes = episodes
                   }
               case .failure(let error):
                   print("Error fetching episode data: \(error.localizedDescription)")
               }
           }
       }
    
}

