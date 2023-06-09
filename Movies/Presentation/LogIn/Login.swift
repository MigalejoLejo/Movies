//
//  LogIn.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    @State var showWarning: Bool = false
    @State var loggingIn: Bool = false
    @State var warning:Warning = Warning(type: .warning, color: .red, message: "")
    
    var body: some View {
            VStack{
                
                LoginThumbnail()
                
                InputField(input: $loginViewModel.username, fieldTitle: "username")

                InputField(input: $loginViewModel.password, isSecure: true, fieldTitle: "password")
                
                if showWarning {
                    WarningComponent (warning: $warning)
                }
               
            
                
                            
                Spacer()
                
                LoginButton()
               
            }
            .onAppear{
                showWarning = false
            }
            .padding()
        
       
    }
    
   
    
    @ViewBuilder
    func LoginButton () -> some View {
        Button("Login") {
            
            if loginViewModel.username.isEmpty || loginViewModel.password.isEmpty {
                
                warning.type = .warning
                warning.color = .red
                warning.message = "falta user name"
                showWarning = true
            } else {
                warning.type = .logging
                loginViewModel.login()
                showWarning = true

            }
            
            
        }
        .disabled(!loginViewModel.validate())
        .frame(
            maxWidth: 300,
            maxHeight: 45)
        .background(.green)
        .foregroundColor(.white)
        .bold()
        .cornerRadius(8)
        
    }
}




struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
