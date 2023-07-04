//
//  PersonDetailsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import SwiftUI
import Kingfisher

struct PersonDetailsView: View {
    @EnvironmentObject var contentViewModel:ContentViewModel
    @ObservedObject var model = PersonDetailsViewModel()
    
    @State var images: [Profile] = []
    
    @State private var isExpanded: Bool = false
    @State private var isPresented: Bool = false
    
    init(id:Int){
        model.loadDetails(id:id)
    }
    
    var body: some View {
        GeometryReader{proxy in
            ScrollView {
                Header(proxy: proxy, path: model.person?.profilePath ?? "")
                Profile(person: model.person, proxy: proxy)
                PersonImagesRow(images: $images)
                PosterRow(results: model.person?.combinedCredits?.cast, title: "movies_and_tv".localizedLanguage())
            }
            .onReceive(model.person.publisher, perform: { person in
                images = person.images?.profiles ?? []
            })
          
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        contentViewModel.navToHome()
                    } label: {
                        Image(systemName: "house")
                    }
                }
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
                .placeholder{
                    Image("placeholder-poster")
                        .resizable()
                        .scaledToFill()
                }
                .resizable()
                .frame(width: 150, height: 220)
                .scaledToFill()
                .cornerRadius(10)
                
        }
    }
    
    @ViewBuilder
    func Profile (person: PeopleDetails?, proxy:GeometryProxy) -> some View {
       
        Text(person?.name ?? "")
            .font(.largeTitle)
            .bold()
        
        Text(person?.knownForDepartment ?? "")
            .font(.title2)
            .bold()
        
        
            model.getBirthAndDeathDetails()
            .multilineTextAlignment(.center)
                .padding(.vertical, 5)
        
        
        if let biography = person?.biography, !biography.isEmpty {
            Text(biography)
                .lineLimit(isExpanded ? .max : 10)
                .padding()
                .onTapGesture {
                    isExpanded.toggle()
                }
            .padding(.bottom)
        } else {
            Text("No biographical information for this person available")
        }
        
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 1000)
            .environmentObject(ContentViewModel())
        
    }
}
