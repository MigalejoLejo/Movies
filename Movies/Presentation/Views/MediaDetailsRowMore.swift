//
//  MediaDetailsRowMore.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import SwiftUI

struct MediaDetailsRowMore: View {
    var images:[Result]
    var title: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: columns) {
                ForEach(images, id: \.uuid) { card in
                    Card(result:card).toDetailsView(result: card)
                }
            }
        }.navigationTitle(title)
    }
}

struct MediaDetailsRowMore_Previews: PreviewProvider {
    @State static var images:[Result] = []
    @State static var title = ""
    static var previews: some View {
        MediaDetailsRowMore(images: images, title: title)
    }
}
