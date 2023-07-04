//
//  ContentView.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var userService: UserService = .sharedInstance
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    
    
    @EnvironmentObject var contentViewModel:ContentViewModel
    
    @State var selection = "home"
    var hasFinishedLoading:Bool {
        return hasFinishedLoadingLists && hasFinishedLoadingFavorites
    }
    @State var hasFinishedLoadingLists: Bool = false
    @State var hasFinishedLoadingFavorites:Bool = false
    
    
    var body: some View {
        GeometryReader { proxy in
            if userService.isLoggedIn {
                TabView(selection: $selection) {
                    HomeView(model: homeViewModel, isLoading: hasFinishedLoading)
                        .tabItem{ Label("home".localizedLanguage(),systemImage: "house")}

                        .tag("home")
                    
                    FavoritesView(model: favoritesViewModel)
                    
                        .tabItem{ Label("favorites".localizedLanguage() ,systemImage: "star")}
                        .tag("favorites")
                    
                    SettingsView()
                        .tabItem {Label("settings".localizedLanguage(), systemImage: "gear")}
                        .tag("settings")
                    
                }
                .onAppear {
                    correctTabBug()
                }
                
                .overlay {
                    if !(hasFinishedLoading) {
                        LoadingView(width: proxy.frame(in: .global).width, height: proxy.size.height)
                            .onChange(of: homeViewModel.hasFinishedLoading) { status in
                                withAnimation(.easeInOut(duration: 0.35)){
                                    hasFinishedLoadingLists = status
                                }
                            }
                            .onChange(of: favoritesViewModel.hasFinishedLoading) { status in
                                withAnimation(.easeInOut(duration: 0.35)){
                                    hasFinishedLoadingFavorites = status
                                }
                            }
                        
                    }
                }
                .onTapGesture(count: 2){
                    contentViewModel.navToHome()
                }
                
                .onAppear{
                    homeViewModel.fetchLists()
                }
                .onChange(of:UserService.sharedInstance.updateFavorites, perform: { _ in
                    favoritesViewModel.updateFavorites()
                })
                .onChange(of: UserService.sharedInstance.appLanguage, perform: {_ in
                    contentViewModel.homeViewID = UUID()
                    homeViewModel.reload()
                    favoritesViewModel.updateFavorites()

                })
                
                
            } else { Login() }
            
            
        }
        .id(contentViewModel.homeViewID)
        
    }
    
    func correctTabBug() {
        // correct the transparency bug for Tab bars
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // correct the transparency bug for Navigation bars
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
