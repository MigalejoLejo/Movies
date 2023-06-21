//
//  PersonImagesRow.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import SwiftUI
import Kingfisher

struct PersonImagesRow: View {
    @State var images:[Profile]
    @State var isPresented:Bool = false
    @State var imageIndex:Int = 0
    @State private var offset = CGSize(width: 0, height: 0)

    var body: some View {
        ScrollView (.horizontal){
            HStack{
                ForEach (images.indices, id: \.self) { index in
                    KFImage(URL(string:"https://image.tmdb.org/t/p/w500/\(images[index].filePath ?? "")"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .padding(-5)
                        .onTapGesture {
                            imageIndex = index
                            print(imageIndex)
                            isPresented.toggle()
                        }
                        .sheet(isPresented: $isPresented) {
                            ImagesTabNav(images: $images, imageIndex: $imageIndex, isPresented: $isPresented)
                        }
                }
            }
        }
    }
}

struct PersonImagesRow_Previews: PreviewProvider {
    @State static var images: [Profile] = [Profile( filePath: "/ucdif7QOPZAdChFbW9C4ylXptRK.jpg"), Profile(filePath: "/8iDSGu5l93N7benjf6b3AysBore.jpg"), Profile(filePath: "/zkOBmmSgOsMPGs2DvpM8E4dXpBk.jpg")]
    static var previews: some View {
        PersonImagesRow(images: images)
    }
}
