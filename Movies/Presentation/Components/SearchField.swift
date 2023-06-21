//
//  SearchField.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct SearchField: View {

    var title:String = "Search"
//    @StateObject var model:SearchViewModel
    
    @Binding var searchItem:String
    @Binding var selectedContent: ResultType
    
    @State var input:String = ""
    @State var showCancel:Bool = false
    
    @FocusState var isFocused:Bool
    
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField(title, text: $input)
                        .onSubmit {
                            searchItem = input
//                            model.search(item: searchItem, in: selectedContent.rawValue)
                        }
                        .focused($isFocused)
                    
                    if !input.isEmpty{
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                            .scaleEffect(1.4)
                            .onTapGesture {
                                input = ""
                            }
                            .transition(.slide)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()){
                        showCancel = true
                    }
                }
                .padding(10)
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                
                
                if showCancel {
                    Button("Cancel"){
                        withAnimation{
                            showCancel = false
                            isFocused = false
                            
                        }
                    }
                    .foregroundColor(.blue)
                    .font(.title3)
                    .transition(.slide)
                }
            }
            
            if !input.isEmpty {
                Picker("Search", selection: $selectedContent) {
                    Text("Movie").tag(ResultType.movie)
                    Text("TV").tag(ResultType.tv)
                   }
                .pickerStyle(.segmented)
                .onChange(of: selectedContent, perform: { newValue in
                    searchItem = input
//                    model.search(item: searchItem, in: selectedContent.rawValue)

                })
            }
        }
          
        
    }
}

struct SearchField_Previews: PreviewProvider {
    @State static var searchItem = ""
    @State static var selectedContent: ResultType = .movie
    @ObservedObject static var model = SearchViewModel()

    static var previews: some View {
        SearchField(searchItem: $searchItem, selectedContent: $selectedContent)
    }
}
