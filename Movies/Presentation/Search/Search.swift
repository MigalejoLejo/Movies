//
//  Search.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct Search: View {
    
    @State var searchItem = ""
    @State private var selectedContent: ResultType = .movie
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var results:[Result] = []
    
    
    
    var body: some View {
        VStack{
           SearchField(searchItem: $searchItem)
                .onSubmit {
                    results = Dummy.getResults(30)
                }
            
            if !searchItem.isEmpty {
                Picker("Search", selection: $selectedContent) {
                    Text("Movie").tag(ResultType.movie)
                    Text("TV").tag(ResultType.tv)
                   }
                .pickerStyle(.segmented)
            }
          
            ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(results, id: \.uuid) { result in
                            ImageCard(result: result)
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
