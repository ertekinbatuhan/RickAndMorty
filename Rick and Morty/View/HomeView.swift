import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel = CharactersViewModel()
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(CharacterHelper.filteredResults(results: viewModel.results, search: search)) { result in
                        NavigationLink(destination: DetailsView(character: result)) {
                            GeometryReader { geometry in
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
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                        Text(result.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text(result.species.rawValue)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        
                                        HStack(spacing: 4) {
                                            Circle()
                                                .frame(width: 8, height: 8)
                                                .foregroundColor(result.status == .alive ? .green : .red)
                                            
                                            Text(result.status.rawValue)
                                                .font(.subheadline)
                                                .foregroundColor(result.status == .alive ? .green : .red)
                                        }
                                    }
                                    .frame(width: geometry.size.width - 116)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .frame(width: geometry.size.width)
                            }
                            .frame(height: 150)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 16)
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

