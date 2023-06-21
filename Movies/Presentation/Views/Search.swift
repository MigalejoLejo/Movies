//
//  Search.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct Search: View {
    
    @ObservedObject var model = SearchViewModel()

    @State var searchItem = ""
    @State var selectedContent: ResultType = .movie

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var results:[Result] = []
    
    
    
    var body: some View {
        VStack{
            SearchField(model: model, searchItem: $searchItem, selectedContent: $selectedContent)
                .onSubmit {
                }
            
           
            ScrollView(.vertical){
                LazyVGrid(columns: columns) {
                    ForEach(model.results, id: \.uuid) { card in
                        Card(result:card).toDetailsView(result: card)
                    }
                    Text("").onAppear{
                        model.getMoreResults()
                    }
                }
            }
            
            
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)

        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
