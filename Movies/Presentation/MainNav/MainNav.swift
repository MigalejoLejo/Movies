//
//  MainNav.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct MainNav: View {
    
    @State var results: [Result] = Dummy.getResults(10)
    @State var showFullToolbar = true
    
    
    var body: some View {
        
            ScrollView{
                
                ImageCardRow(title: "On the Air", ImageCards: results)
                ImageCardRow(title: "Popular on TV", ImageCards: results)
                ImageCardRow(title: "Popular Movies", ImageCards: results)
                
            
            }
            .navigationTitle("Movie")
            .padding(.horizontal)
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    Button("Logout"){
                        UserService.sharedInstance.unauthenticate()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: Search()){
                        Image(systemName: "magnifyingglass")
                    }
                }
                
            }
        
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainNav_Previews: PreviewProvider {
    static var previews: some View {
        MainNav()
    }
}
