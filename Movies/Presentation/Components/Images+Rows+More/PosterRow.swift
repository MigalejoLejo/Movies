//
//  PosterRow.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 21/6/23.
//

import SwiftUI

struct PosterRow: View {
    
    var results: [Result]?
    let title: String
    var type: ResultType = .movie
    
    var body: some View {
        
        if let results = results, results.count > 0 {
            VStack{
                HStack{
                    Text(title)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                    NavigationLink(destination: MediaDetailsRowMore(images: results, title: title)){
                        NavigationLable()
                            .padding(.horizontal)
                    }
                }
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(results, id: \.uuid) { card in
                            Card(result:card).toDetailsView(result: card)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

struct PosterRow_Previews: PreviewProvider {
    
    static var previews: some View {
        PosterRow( title: "Test")
    }
}
