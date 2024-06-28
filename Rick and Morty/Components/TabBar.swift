import SwiftUI

struct TabBar: View {
    
    @State private var tabSelection = 1
    
    var body: some View{
        
        TabView(selection : $tabSelection){
           
            HomeView().tag(1)
            
            EpisodeView().tag(2)
            
           LocationView().tag(3)
        }
        
        .overlay(alignment : .bottom){
            
            CustomTabView(tabSelection: $tabSelection)
        }
    }
    
}

#Preview {
    TabBar()
}

