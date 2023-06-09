//
//  ContentView.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

struct ContentView: View {

    // Userservice
    // si tenemos sessionid != nil entrar a home view
    
    @State var resultText:String = Dummy.messages
    @State var isLoggedIn: Bool = UserService.sharedInstance.isLoggedIn

    
    var body: some View {
        NavigationView{
            if isLoggedIn {
                MainNav()
            } else {
                Login()
            }
        }
        .onReceive(UserService.sharedInstance.$isLoggedIn) { value in
            isLoggedIn = value
        }
       
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
