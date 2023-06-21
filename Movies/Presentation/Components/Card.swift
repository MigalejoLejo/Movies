//
//  Card.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 20/6/23.
//

import SwiftUI

struct Card: View {
    
    var result:Result
    
    var body: some View {
        if result.type == .person {
            ImageCard(result: result, height: 110, alpha: 0.65)
        } else {
            ImageCard(result: result)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var result:Result = Result(id: 0, title: "", subtitle: "", image: "", type: .movie)
    static var previews: some View {
        Card(result: result)
    }
}
