//
//  EpisodeView.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 28.06.2024.
//

import SwiftUI

struct EpisodeView: View {
    
    @StateObject private var viewModel = EpisodesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(EpisodeHelper.filteredEpisodes(episodes: viewModel.episodes, searchText: searchText)) { episode in
                EpisodeRow(episode: episode)
            }
            
            .searchable(text: $searchText)
            .listStyle(PlainListStyle())
            .navigationTitle("Episodes")
            .onAppear {
                viewModel.loadEpisodes()
            }
        }
    }
}

struct EpisodeRow: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(episode.episode)
                .font(.caption).frame(maxWidth: .infinity)
                .foregroundColor(.red)
            
            Text(episode.name)
                .font(.headline)
            
            Text("Air Date: \(episode.airDate)")
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    EpisodeView()
}
