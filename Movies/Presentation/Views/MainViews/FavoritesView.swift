//
//  FavoritesView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 27/6/23.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var model: FavoritesViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var selectedContent: ResultType = .movie
    @State private var isLoading:Bool = true
    @State private var isLoadingMovies = false
    @State private var isLoadingSeries = false
    @State private var pickerIsVisible = true
    @State private var rect: CGRect = .zero
    private let id = UUID()
    private static let topId = "topElement"
    
    
    var body: some View {
        NavigationStack{
            ScrollViewReader{ reader in
                ScrollView(.vertical){
                    Picker("search".localizedLanguage(), selection: $selectedContent) {
                        Text("movies".localizedLanguage()).tag(ResultType.movie)
                        Text("tv".localizedLanguage()).tag(ResultType.person)
                    }
                    .id(FavoritesView.topId)
                    .pickerStyle(.segmented)
                    .padding(.top)
                    
                    .background {
                        GeometryReader {
                            Color.clear
                                .onChange(of: $0.frame(in: .named(id))) { coordinates in
                                    if coordinates.origin.y < -50 {
                                        pickerIsVisible = false
                                    } else {
                                        pickerIsVisible = true
                                    }
                                }
                        }
                    }
                    
                    
                    
                    
                    if selectedContent == .movie {
                        LazyVGrid(columns: columns) {
                            ForEach(model.favoriteMovies.reversed(), id: \.id) { card in
                                Card(result:card).toDetailsView(result: card)
                            }
                            
                        }
                    }  else {
                        LazyVGrid(columns: columns) {
                            ForEach(model.favoriteSeries.reversed(), id: \.id) { card in
                                Card(result:card).toDetailsView(result: card)
                            }
                            
                        }
                    }
                }
                .coordinateSpace(name: id)
                .navigationTitle("favorites".localizedLanguage())
                .toolbar{
                    if !pickerIsVisible {
                        ToolbarItem(placement: .navigationBarTrailing){
                            Picker("search".localizedLanguage(), selection: $selectedContent) {
                                Text("movies".localizedLanguage()).tag(ResultType.movie)
                                Text("tv".localizedLanguage()).tag(ResultType.person)
                            }
                        }
                    }
                }
                .onChange(of: selectedContent) { _ in
                    withAnimation {
                        reader.scrollTo(Self.topId, anchor: .top)
                    }
                }
            }
            
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    @StateObject static var model:FavoritesViewModel = FavoritesViewModel()
    static var previews: some View {
        FavoritesView(model:model)
    }
}
