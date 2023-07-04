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
        NavigationStack{
            VStack (spacing: 30) {
                if UIDevice.current.localizedModel == "iPhone" {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("language".localizedLanguage())
                            .font(.title2)
                            .bold()
                        LanguagePicker()
                    }
                    
                    VStack (alignment: .leading, spacing: 5) {
                        Text("dark_mode".localizedLanguage())
                            .font(.title2)
                            .bold()
                        HStack{
                            Toggle("activate".localizedLanguage(), isOn: $isDarkMode)
                        }
                    }
                    
                    
                } else if UIDevice.current.localizedModel == "iPad" {
                    VStack{
                        HStack (alignment: .center, spacing: 60) {
                            Text("language".localizedLanguage())
                                .font(.title2)
                                .bold()
                            LanguagePicker()
                        }
                        .padding(.vertical)
                        
                        HStack (alignment: .center) {
                            Text("dark_mode".localizedLanguage())
                                .font(.title2)
                                .bold()
                            Spacer()
                            Toggle("", isOn: $isDarkMode)
                                .frame(width: 150)
                            
                        }
                    }.frame(width: 400)
                }
                
                
                VStack (alignment: .center){
                    Spacer()
                    Button("credits".localizedLanguage()){
                        showCredits.toggle()
                    }
                    .font(.title2)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.blue, lineWidth: 2)
                    )
                    .sheet(isPresented: $showCredits) {
                        CreditsView(isPresented: $showCredits)
                    }
                }
                Spacer()
            }
            .padding(30)
            .navigationTitle("Settings".localizedLanguage())
        }
        
        
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    @ViewBuilder
    func LanguagePicker() -> some View{
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
}

struct SettingsView_Previews: PreviewProvider {
    @State static var selection = 1
    static var previews: some View {
        SettingsView()
    }
}
