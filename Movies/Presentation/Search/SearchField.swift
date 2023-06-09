//
//  SearchField.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct SearchField: View {
    
    @Binding var searchItem:String
    var title:String = "Search"
    
    @State var showCancel:Bool = false
    
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField(title, text: $searchItem)
                   
                if !searchItem.isEmpty{
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                        .scaleEffect(1.4)
                        .onTapGesture {
                            searchItem = ""
                        }
                        .transition(.slide)
                }
            }
            .onTapGesture {
                withAnimation{
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
                    }
                }
                .foregroundColor(.blue)
                .font(.title3)
                .transition(.slide)
            }
        }
        
       
          
        
    }
}

struct SearchField_Previews: PreviewProvider {
    @State static var searchItem = ""
    static var previews: some View {
        SearchField(searchItem: $searchItem)
    }
}
