//
//  NavigationLable.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 20/6/23.
//

import SwiftUI

struct NavigationLable: View {
    var body: some View {
        HStack{
            Text("more".localizedLanguage()).foregroundColor(.blue)
            Image(systemName: "chevron.right").foregroundColor(.blue)
        }
    }
}

struct NavigationLable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLable()
    }
}
