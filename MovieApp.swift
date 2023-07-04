//
//  MovieApp.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

@main
struct MovieApp: App {
    
    @StateObject var model:ContentViewModel = ContentViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup { 
            ContentView()
                .environmentObject(model)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}


