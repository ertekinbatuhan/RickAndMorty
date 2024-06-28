import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = CharactersViewModel()
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            List(CharacterHelper.filteredResults(results: viewModel.results, search: search)) { result in
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
                            
                            HStack(spacing: 4) {
                                Text(result.status.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(result.status == .alive ? .green : .red)
                                
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(result.status == .alive ? .green : .red)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .searchable(text: $search)
            .navigationTitle("Characters")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

