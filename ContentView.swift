//
//  ContentView.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    //    @State var resultText:String = Dummy.messages
    
    @ObservedObject var us:UserService = .sharedInstance
    @ObservedObject var homeViewModel = HomeViewModel()
    
    @State var showAction = true
    @State var selection = 0
    @State var visibleTabs = true
    @State var isLoading:Bool = false
    
    
    var body: some View {
     
            GeometryReader { proxy in
                ZStack{
                    if us.isLoggedIn {
                        NavigationStack {
                            TabView(selection: $selection) {
                                HomeView(model: homeViewModel, isLoading: $isLoading)
                                    .tabItem{
                                        Label("Home", systemImage: "house")
                                            .background(.green)
                                    }
                                    .tag(0)
                                
                                CreditsView()
                                    .tabItem {Label("Credits", systemImage: "gear")}
                                    .tag(1)
                            }
                        }
                        .onAppear{
                            isLoading = true
                            if homeViewModel.rows.isEmpty {
                                homeViewModel.fetchLists()
                            } else { isLoading = false }
                        }
                        
                    } else { Login() }
                }
                .overlay {
                    if isLoading {
                        LoadingView(width: proxy.frame(in: .global).width, height: proxy.size.height)
                            .onChange(of: homeViewModel.isLoading) { status in
                                withAnimation(.easeInOut(duration: 0.35)){
                                    isLoading = status
                                }
                            }
                    }
            
           
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
