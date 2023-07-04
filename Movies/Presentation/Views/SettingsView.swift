//
//  Credits.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 22/6/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedContent: Language = Language(rawValue: UserService.sharedInstance.appLanguage) ?? .en
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var showCredits = false
    
    
    
    var body: some View {
        NavigationView{
            VStack (spacing: 30) {
                VStack (alignment: .leading, spacing: 10) {
                    Text("language".localizedLanguage())
                        .font(.title2)
                        .bold()
                    Picker(UserService.sharedInstance.appLanguage, selection: $selectedContent) {
                        Text("English").tag(Language.en)
                        Text("Spanish").tag(Language.es)
                        Text("German").tag(Language.de)
                        
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedContent) { selectedLanguage in
                        UserService.sharedInstance.setLanguage(language: selectedLanguage)
                        
                    }
                }
                    
                   
                   
                    
                VStack (alignment: .leading, spacing: 5) {
                    Text("dark_mode".localizedLanguage())
                        .font(.title2)
                        .bold()
                    HStack{
                        Toggle("activate", isOn: $isDarkMode)
                    }
                }
                
                
                
                VStack (alignment: .center){
                    Spacer()
                    Button("credits".localizedLanguage()){
                        showCredits.toggle()
                    }
                    .font(.title)
                    .sheet(isPresented: $showCredits) {
                        CreditsView(isPresented: $showCredits)
                    }
                }
               
            
            Spacer()
            
            
        }
        .padding()
        .navigationTitle("Settings".localizedLanguage())
    }
    
    
        .navigationViewStyle(StackNavigationViewStyle())
    
}
}

struct SettingsView_Previews: PreviewProvider {
    @State static var selection = 1
    static var previews: some View {
        SettingsView()
    }
}
