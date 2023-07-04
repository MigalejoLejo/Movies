//
//  LoginThumbnail.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct LoginThumbnail: View {
    var body: some View {
        VStack{
            Text("🎬")
                .font(.system(size: 80))
            Text("superMOVIE")
                .font(.system(size: 50))
                .bold()
        }
        .frame(maxHeight: 370)
    }
}

struct LoginThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        LoginThumbnail()
    }
}
