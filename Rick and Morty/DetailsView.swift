//
//  DetailsView.swift
//  Rick and Morty
//
//  Created by Batuhan Berk Ertekin on 27.06.2024.
//

import SwiftUI

struct DetailsView: View {
    let character: Result
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                
                Text(character.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(character.status.rawValue)
                    .font(.title2)
                    .foregroundColor(character.status == .alive ? .green : .red)
                
                Text(character.species.rawValue)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Origin:")
                            .font(.headline)
                        Spacer()
                        Text(character.origin.name)
                    }
                    
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Location:")
                            .font(.headline)
                        Spacer()
                        Text(character.location.name)
                    }
                    
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Gender:")
                            .font(.headline)
                        Spacer()
                        Text(character.gender.rawValue)
                    }
                    
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Type:")
                            .font(.headline)
                        Spacer()
                        Text(character.type.isEmpty ? "N/A" : character.type)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
        }
        .navigationTitle(character.name)
    }
}

#Preview {
    DetailsView(character: Result(id: 1, name: "Rick Sanchez", status: .alive, species: .human, type: "", gender: .male, origin: Location(name: "Earth (C-137)", url: ""), location: Location(name: "Earth (Replacement Dimension)", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: ""))
}

