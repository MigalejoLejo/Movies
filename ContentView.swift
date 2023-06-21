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
    
    var body: some View {
       
        NavigationStack {
        if us.isLoggedIn {
                HomeView()
            } else {
                Login()
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
