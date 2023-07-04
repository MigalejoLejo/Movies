//
//  Search.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI
import LazyViewSwiftUI

struct Search: View {
    
    @ObservedObject var model = SearchViewModel()
    
    @State private var searchItem = ""
    @State private var selectedContent: ResultType = .movie
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        LazyView (VStack{
            SearchField(searchItem: $searchItem, selectedContent: $selectedContent)
                .padding(.top)
            
            ScrollView(.vertical){
                LazyVGrid(columns: columns) {
                    ForEach(model.results, id: \.uuid) { card in
                        Card(result:card).toDetailsView(result: card)
                    }
                    Text("").onAppear{model.getMoreResults()}
                }
            }
            
            Text("\(model.page) \("of".localizedLanguage()) \(model.totalPages) \("paginas".localizedLanguage()) ")
                .padding()
            
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: searchItem){ item in
            model.search(item: item, in: selectedContent.rawValue)
        }
        .onChange(of: selectedContent){ item in
            model.search(item: searchItem, in: item.rawValue)
        })
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
