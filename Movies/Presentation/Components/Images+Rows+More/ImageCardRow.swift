//
//  ImageCardRow.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

struct ImageCardRow: View {
    
    var title: String = "This is the Title"
    var imageCards:[Result] = []
    var endpoint: String = ""
    var params:[String:Any] = [:]
    var type: ResultType = .movie
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                Spacer()
                NavigationLink(destination: ImageCardRowMore(title: title, path: endpoint)){
                   NavigationLable()
                        .padding(.horizontal, 5)
                }
            }
           
            ScrollView(.horizontal){
                HStack{
                    ForEach(imageCards, id: \.uuid) { card in
                        Card(result:card).toDetailsView(result: card)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ImageCardRow_Previews: PreviewProvider {
    static var results = Dummy.getResults(10)

    static var previews: some View {
        ImageCardRow(imageCards:results)
    }
}
