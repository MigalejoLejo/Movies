//
//  ImagesTabNav.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 21/6/23.
//

import SwiftUI
import Kingfisher

struct ImagesTabNav: View {
    
    @Binding var images:[Profile]
    @Binding var imageIndex:Int
    @Binding var isPresented:Bool
    
    
    var body: some View {
        ZStack{
            TabView(selection: $imageIndex){
                ForEach(images.indices, id: \.self) { index in
                    KFImage(URL(string:"https://image.tmdb.org/t/p/w500/\(images[index].filePath ?? "")"))
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .greatestFiniteMagnitude)
                        .onAppear{print(imageIndex)}
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            DismissSheetButton(isPresented: $isPresented)
        }
        .background(.black)
    }
}

struct ImagesTabNav_Previews: PreviewProvider {
    @State static var images:[Profile] = []
    @State static var isPresented:Bool = false
    @State static var imageIndex:Int = 0
    
    static var previews: some View {
        ImagesTabNav(images: $images, imageIndex: $imageIndex, isPresented: $isPresented)
    }
}
