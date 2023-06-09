//
//  ImageCardRow.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import SwiftUI

struct ImageCardRow: View {
    
    var title: String = "This is the Title"
    var ImageCards:[Result] = []
    
    
    var body: some View {
        VStack{
            
            HStack{
                Text(title)
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink(destination: Text("Hello World")){
                   NavigationLable()
                }
            }
           
            
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(ImageCards, id: \.uuid) { card in
                        Card(result:card)
                    }
                }
            }

            
            
        }
    }
    
    
    
    @ViewBuilder
    func NavigationLable () -> some View{
        HStack{
            Text("more")
                .foregroundColor(.blue)
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
    }
    
   @ViewBuilder
    func Card (result:Result) -> some View {
        if result.type == .person {
            ImageCard(result: result, height: 110, alpha: 0.65)
        } else {
            ImageCard(result: result)
        }
    }
    
}

struct ImageCardRow_Previews: PreviewProvider {
    static var results = Dummy.getResults(10)
    
    static var previews: some View {
        ImageCardRow(ImageCards:results)
    }
}
