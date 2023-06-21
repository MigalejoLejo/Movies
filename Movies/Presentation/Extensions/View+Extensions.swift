//
//  View+Extentions.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func toDetailsView(result:Result) -> some View{
        NavigationLink (destination: destination(result: result)){
            self
        }.buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func destination(result:Result) -> some View {
        switch result.type {
        case .movie, .tv:
            MediaDetailsView(id: result.id, type: result.type)
                .onAppear{
                    print(result)
                }
            
        case .person, .cast, .credit:
            PersonDetailsView(id: result.id)
        }
    }
}

