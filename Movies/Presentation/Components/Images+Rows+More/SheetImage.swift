//
//  ImageC.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI
import Kingfisher

struct SheetImage: View {
    
    var url:String
    var placeholder:String = "placeholder-poster"
    
    
   
    var body: some View {
        KFImage(URL(string:url))
            .placeholder{
                Image(placeholder)
                    .resizable()
                    .scaledToFill()
            }
            .cacheOriginalImage()
            .resizable()
            .frame(maxHeight: .greatestFiniteMagnitude)
            .scaledToFit()
           
    }
}


struct SheetImage_Previews: PreviewProvider {
   
    static var url = "\(Env.image_url)\(ImageSize.w500)/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"
    
    static var previews: some View {
        Img(url: url)
    }
}
