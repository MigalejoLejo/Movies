//
//  MainNav.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var mainViewModel = HomeViewModel()
    @State var showFullToolbar = true
    
    var body: some View {
        ScrollView{
            ForEach(mainViewModel.rows) { row in
                ImageCardRow(title: row.title, imageCards: row.list.results, endpoint: row.endpoint , type: .movie)
            }
        }
        .navigationTitle("Home")
        .edgesIgnoringSafeArea(.bottom)
        .scrollIndicators(.hidden)
        .toolbar{
            ToolbarItem(placement:.navigationBarLeading){
                Button("Logout"){
                    mainViewModel.logout()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: Search()){
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .onAppear{
            if mainViewModel.rows.isEmpty {
                mainViewModel.fetchLists()
            }
        }
    }
}

struct MainNav_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
