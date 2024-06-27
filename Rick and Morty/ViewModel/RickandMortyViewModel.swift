//
//  RickandMortyViewModel.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 27.06.2024.
//

import Foundation

class RickandMortyViewModel: ObservableObject {
    
    @Published var results = [Result]()
    
    func fetchData(url: URL, completion: @escaping (Swift.Result<[Result], RickAndMortyError>) -> Void) {
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
                let decodedData = try JSONDecoder().decode(RickandMorty.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(.dataParseError))
            }
        }.resume()
    }
    
    func loadData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        fetchData(url: url) { result in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.results = results
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    
}


enum RickAndMortyError: Error {
    case badUrl
    case noData
    case dataParseError
}



