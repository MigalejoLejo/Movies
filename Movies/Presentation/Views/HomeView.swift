//
//  MainNav.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var model: HomeViewModel
    var isLoading: Bool
    
    @State private var isActive : Bool = false
    @State private var showFullToolbar = true

    
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView{
                ScrollView{
                    ForEach(model.rows) { row in
                        ImageCardRow(title: row.title, imageCards: row.list.results, endpoint: row.endpoint , type: .movie)
                            .padding(.top)

                    }
                }
                .navigationTitle("SuperMOVIE")
                .scrollIndicators(.hidden)
                .toolbar{
                        ToolbarItem(placement:.navigationBarLeading){
                            Button(!isLoading ? "" : "logout".localizedLanguage()){
                                    model.logout()
                                    model.rows = []
                                }
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink(destination: Search()){
                                if isLoading {Image(systemName:"magnifyingglass") }
                            }
                    }
                }
            }
           
        }
        
    }
}

struct MainNav_Previews: PreviewProvider {
    @StateObject static var testModel = HomeViewModel()
    static var isLoading:Bool = true

    static var previews: some View {
        HomeView(model: testModel, isLoading: isLoading)
    }
}
