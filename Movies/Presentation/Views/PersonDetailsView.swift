//
//  PersonDetailsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import SwiftUI
import Kingfisher

struct PersonDetailsView: View {
    
    
    @ObservedObject var model = PersonDetailsViewModel()
    @State var isExpanded: Bool = false
    @State var isPresented: Bool = false
    
    init(id:Int){
        model.loadDetails(id:id)
    }
    
    var body: some View {
        GeometryReader{proxy in
            ScrollView {
                Header(proxy: proxy, path: model.person?.profilePath ?? "")
                Profile(person: model.person)
                PersonImagesRow(images: model.person?.images?.profiles ?? [])
                PosterRow(results: model.person?.combinedCredits?.cast, title: "Movies and TV")
            }
        }
    }
}






extension PersonDetailsView{
    @ViewBuilder
    func Header(proxy: GeometryProxy, path:String) -> some View{
        ZStack {
            VStack{
                Rectangle()
                    .frame(width: proxy.size.width, height: 150)
                    .foregroundColor(.clear)
                    .background{
                        KFImage(URL(string:"https://image.tmdb.org/t/p/w500/\(path)"))
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 10)
                    }
                    .clipped()
                Rectangle()
                    .frame(width: proxy.size.width, height: 150)
                    .foregroundColor(.clear)
            }
            .frame(width: proxy.frame(in: .local).width, height: 300)
            
            KFImage(URL(string:"https://image.tmdb.org/t/p/w500/\(path)"))
                .resizable()
                .frame(width: 150, height: 220)
                .scaledToFill()
                .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    func Profile (person: PeopleDetails?) -> some View {
        Text(person?.name ?? "")
            .font(.largeTitle)
            .bold()
        
        Text(person?.knownForDepartment ?? "")
            .font(.title2)
            .bold()
        Text(person?.biography ?? "")
            .lineLimit(isExpanded ? .max : 10)
            .padding()
            .onTapGesture {
                isExpanded.toggle()
            }
        .padding(.vertical)
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 13)
    }
}
