//
//  LoadingView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 23/6/23.
//

import SwiftUI

struct LoadingView: View {
    @State  var width: CGFloat
    @State  var height: CGFloat
    
    var body: some View {
        
        VStack{
            VStack{
                VStack{
                    LottieView(name: "action.json")
                    LottieView(name:"loading.json")
                    
                    
                }
                .frame(width: 300, height: 580)
                .padding()
            }
            .frame(width: width, height: height)
            
            
            
        }
        .background(.linearGradient(colors: [.black, .indigo, .blue], startPoint: .bottomLeading, endPoint: .topTrailing))
        
        
        
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    @State static var width: CGFloat = 400
    @State static var height: CGFloat = 600
    static var previews: some View {
        LoadingView(width: width, height: height)
    }
}
