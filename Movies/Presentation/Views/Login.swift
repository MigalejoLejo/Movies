//
//  LogIn.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    
    @State private var showWarning: Bool = false
    @State private var loggingIn: Bool = false
    @State private var warning:Warning = Warning(type: .warning, color: .red, message: "")
    
    
    var body: some View {
        VStack{
            
            LoginThumbnail()
            
            InputField(input: $loginViewModel.username, fieldTitle: "username".localizedLanguage())
            
            InputField(input: $loginViewModel.password, isSecure: true, fieldTitle:"password".localizedLanguage())
            
            VStack{ if showWarning {WarningComponent (warning: $warning)}}
                .frame(height: 180)
            
            Spacer()
            
            LoginButton()
            
        }
        .padding()
        .onAppear{ showWarning = false }
        .onReceive(loginViewModel.$error) { response in
            warning.message = response?.message ?? ""
            warning.type = .warning
        }
    }
    
    
    @ViewBuilder
    func LoginButton () -> some View {
        Text("Login")
            .disabled(!loginViewModel.validate())
            .frame(maxWidth: 300, maxHeight: 45)
            .background(!loginViewModel.validate() ? .green.opacity(0.3) : .green)
            .foregroundColor(.white)
            .bold()
            .cornerRadius(8)
            .onTapGesture{
                if loginViewModel.username.isEmpty || loginViewModel.password.isEmpty {
                    warning.type = .warning
                    warning.color = .red
                    warning.message = "falta user name"
                    showWarning = true
                } else {
                    warning.type = .logging
                    loginViewModel.login()  //  >>>> LOGIN IS PERFORMED HERE <<<<<<
                    showWarning = true
                }
            }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
