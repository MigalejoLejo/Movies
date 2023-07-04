//
//  DismissSheetButton.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 21/6/23.
//

import SwiftUI

struct DismissSheetButton: View {
    
    var color:Color = .white

    @Binding var isPresented:Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
                    .shadow(color: .gray, radius: 3)
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            .padding()
            Spacer()
        }
    }
}

struct DismissSheetButton_Previews: PreviewProvider {
    @State static var isPresented = false
    static var previews: some View {
        DismissSheetButton(isPresented: $isPresented)
    }
}
