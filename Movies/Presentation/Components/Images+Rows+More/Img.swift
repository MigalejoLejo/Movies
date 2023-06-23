//
//  ImageC.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI
import Kingfisher

struct Img: View {
    
    var url:String
    var width:CGFloat = 90
    var height:CGFloat = 160
    var shadow:CGFloat = 2
    var radius:CGFloat = 10
    var mode:SwiftUI.ContentMode = .fill
    var placeholder:String = "placeholder-poster"
    var alignment:Alignment = .center
    
   
    var body: some View {
        KFImage(URL(string:url))
            .placeholder{
                Image(placeholder)
                    .resizable()
                    .scaledToFill()
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: mode)
            .frame(width: width, height: height, alignment: alignment)
            .clipped()
            .cornerRadius(radius)
            .shadow(radius: shadow)
    }
}


struct Img_Previews: PreviewProvider {
   
    static var url = "\(Env.image_url)\(ImageSize.w500)/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"
    
    static var previews: some View {
        Img(url: url)
    }
}
