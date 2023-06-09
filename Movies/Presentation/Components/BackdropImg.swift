//
//  BackdropImg.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 16/6/23.
//

import SwiftUI
import Kingfisher

struct BackdropImg: View {
    
    var url:String
    var width:CGFloat = 90
    var height:CGFloat = 160
    var shadow:CGFloat = 2
    var radius:CGFloat = 10
    var mode:SwiftUI.ContentMode = .fill
    var placeholder:String = "placeholder-poster"
    
   
    var body: some View {
        KFImage(URL(string:url))
            .placeholder{
                Image(placeholder)
                    .resizable()
                    .frame(maxHeight: 200)
            }
            .cacheOriginalImage()
            .resizable()
            .aspectRatio(contentMode: mode)
            .frame(maxWidth: width)
            .shadow(radius: shadow)
    }
}


struct BackdropImg_Previews: PreviewProvider {
    static var url = "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"
    
    static var previews: some View {
        BackdropImg(url: url)
    }
}
