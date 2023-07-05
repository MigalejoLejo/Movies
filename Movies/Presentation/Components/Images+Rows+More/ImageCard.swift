//
//  PersonListCard.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI
import MovieData

struct ImageCard: View {
    
    let result:Result
    var baseURL:String = Env.image_url+ImageSize.w500.rawValue 
    
    var width:CGFloat = 110
    var height:CGFloat = 160
    var alpha:CGFloat = 0.45
    
    var body: some View {
        VStack (alignment: .leading){
            Img(url: "\(baseURL)\(result.image)", width: width, height: height)
            VStack(alignment: .leading, spacing: 3){
                Text(result.title)
                    .font(.headline)
                    .lineLimit(2)
                if let subtitle = result.subtitle {
                    Text(subtitle).lineLimit(1)
                }
            }
            .frame(minHeight: alpha*height, alignment: .top)
        }
        .frame(width: width)
    }
}


struct ImageCard_Previews: PreviewProvider {
    static var result = Dummy.getResult()
    
    static var previews: some View {
        ImageCard(result: result)
    }
}
