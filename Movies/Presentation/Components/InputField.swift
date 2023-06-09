//
//  InputField.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct InputField: View {
    
    @Binding var input: String
    @State var isSecure: Bool = false
    
    var fieldTitle: String
    
    var bgcolor:Color = .indigo
    var opacity: Double = 0.05
    var borderColor: Color = .gray
    var borderOpacity: Double = 0.5
    var borderWidth:CGFloat = 1
    var cornerRadius: CGFloat = 8
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(fieldTitle.capitalized)
                .bold()
            
            VStack{
                if isSecure {
                    SecureField(fieldTitle.lowercased(), text: $input)
                } else {
                    TextField(fieldTitle.lowercased(), text: $input)
                }
            }
            .padding(8)
                .background(bgcolor.opacity(opacity))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor.opacity(borderOpacity), lineWidth: borderWidth)
                ) 
        }
        .padding(.bottom, 10)
    }
}

struct InputField_Previews: PreviewProvider {
    static let fieldName = "Username"
    @State static var input = ""
   
    static var previews: some View {
        InputField(input:  $input, fieldTitle: fieldName)
    }
}
