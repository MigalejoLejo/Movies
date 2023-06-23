//
//  ImageCardRowMore.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 15/6/23.
//

import SwiftUI

struct ImageCardRowMore: View {
    @ObservedObject var model: ImageCardRowViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    init(title:String, path:String){
        model = ImageCardRowViewModel(path: path, title: title)
        model.fetchResults()
    }
    
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: columns) {
                ForEach(model.results, id: \.uuid) { card in
                    Card(result:card).toDetailsView(result: card)
                }
                Text("").onAppear{
                    model.getMoreResults()
                }
            }
        }.navigationTitle(model.title)
        
    }
}

struct ImageCardRowMore_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardRowMore(title: "Top Rated Movies", path: "movies/popular")
    }
}
