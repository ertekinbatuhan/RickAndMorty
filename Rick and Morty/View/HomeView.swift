//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 27.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = RickandMortyViewModel()
    
    @State private var search = ""
    
    var filteredResults: [Result] {
           if search.isEmpty {
               return viewModel.results
           } else {
               return viewModel.results.filter { $0.name.lowercased().contains(search.lowercased()) }
           }
       }
       
    
    var body: some View {
        NavigationStack {
            List(filteredResults) { result in
                NavigationLink(destination: DetailsView(character: result)) {
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImage(url: URL(string: result.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 3)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(result.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(result.species.rawValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text(result.status.rawValue)
                                .font(.subheadline)
                                .foregroundColor(result.status == .alive ? .green : .red)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }.searchable(text: $search) {
                
            }
            .navigationTitle("Characters")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    HomeView()
}

