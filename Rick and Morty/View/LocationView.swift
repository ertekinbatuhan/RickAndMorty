import SwiftUI

struct LocationView: View {
    
    @StateObject private var viewModel = LocationsViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                   Image("rickandmorty")
                       .resizable()
                       .scaledToFit()
                       .cornerRadius(10.0)
                       .frame(maxWidth: .infinity)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(LocationHelper.filteredLocations(locations: viewModel.locations, searchText: searchText), id: \.id) { location in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(location.name)
                                    .font(.headline).frame(maxWidth : .infinity).foregroundColor(.blue)
                                Text(location.type)
                                    .font(.subheadline).frame(maxWidth : .infinity).foregroundColor(.green)
                                Text(location.dimension).frame(maxWidth : .infinity)
                                    .font(.subheadline).foregroundColor(.red)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    
                    Spacer()
                }
                .onAppear {
                    viewModel.loadLocations()
                }
                .navigationTitle("Locations")
                .padding()
            }.searchable(text: $searchText)
        }
    }
}

#Preview {
    LocationView()
}

