//
//  Warning.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import SwiftUI

struct WarningComponent: View {
    
    @Binding var warning:Warning
    
    var body: some View {
        if warning.type == .warning {
            HStack (alignment: .top){
                warning.icon
                    .foregroundColor(warning.color)
                Text(warning.message)
                    .foregroundColor(warning.color)
            }
        }
        
        if warning.type == .logging {
            HStack (alignment: .top){
                ProgressView()
                Text("Logging in")
                    .foregroundColor(.black)
            }
        }
       
    }
}

struct WarningComponent_Previews: PreviewProvider {
    @State static var warning = Dummy.getWarning(message: "This is ")
    static var previews: some View {
        WarningComponent(warning: $warning)
    }
}
