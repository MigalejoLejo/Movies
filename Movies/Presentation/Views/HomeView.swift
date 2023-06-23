//
//  MainNav.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var model: HomeViewModel
    @State var showFullToolbar = true
    @Binding var isLoading: Bool
    
    
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack{
                
                ZStack{
                    
                    ScrollView{
                        ForEach(model.rows) { row in
                            ImageCardRow(title: row.title, imageCards: row.list.results, endpoint: row.endpoint , type: .movie)
                        }
                    }
                 
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .edgesIgnoringSafeArea(.bottom)
                    .scrollIndicators(.hidden)
                    .toolbar{
                            ToolbarItem(placement:.navigationBarLeading){
                                Button(isLoading ? "" : "Logout"){
                                        model.logout()
                                        model.rows = []
                                    }
                                
                            }
                            ToolbarItem(placement: .navigationBarTrailing){
                                NavigationLink(destination: Search()){
                                    Image(systemName: isLoading ? "" : "magnifyingglass")
                                }
                            
                        }
                    }
                    
                }
                
                
                
               
            }
        }
    }
}

struct MainNav_Previews: PreviewProvider {
    @ObservedObject static var testModel = HomeViewModel()
    @State static var isLoading:Bool = true

    static var previews: some View {
        HomeView(model: testModel, isLoading: $isLoading)
    }
}
