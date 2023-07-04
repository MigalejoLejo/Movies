//
//  CreditsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 3/7/23.
//

import SwiftUI

struct CreditsView: View {
    @Binding var isPresented:Bool

    var body: some View {
        ZStack{
            VStack{
                VStack (alignment: .leading, spacing: 10){
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(.clear)
                    
                   
                    
                    Text("Thank you note")
                        .font(.title2)
                        .bold()
                    Text("This is an app develope for educational purposes. I want to thank PwC for giving me the opportunity to learn and all of the persons involved in the project. Thanks also to my Girlfriend who helps me stay motivated.")
                }
                
                VStack{
                    Image("MyPicture")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 5)
                        }
                        .shadow(radius: 7)
                        .padding()
                    
                    Text("With love")
                        .font(.title)
                        .bold()
                        .foregroundColor(.gray)
                        
                  
                }
                .padding(.top)
                
                Spacer()
                    
            }
                            
            
            .padding()
            
            DismissSheetButton(color: .gray, isPresented: $isPresented)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        CreditsView(isPresented: $isPresented)
    }
}
