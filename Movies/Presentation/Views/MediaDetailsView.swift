//
//  MediaDetailsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import SwiftUI
import Kingfisher
struct MediaDetailsView: View {
    
    @ObservedObject var model: MediaDetailsViewModel
    @State var isExpanded:Bool = false
    @State var isPresented = false

    
    init(id: Int, type: ResultType){
        model = MediaDetailsViewModel(id: id, type: type)
    }
    
    var body: some View {
        if let details = model.mediaDetails?.details{
            GeometryReader{ proxy in
                ScrollView ( .vertical ) {
                    VStack (alignment: .center, spacing: .zero) {
                        
                        backDrop(name: details.backdrop ?? details.poster ?? "", width: proxy.size.width)
                        
                        Group{
                            poster(details:details, proxy: proxy, isPresented: $isPresented)
                            tagline(details: details)
                            overview(details: details)
                        }
                        
                        PosterRow(results: details.credits.castResults , title: "Top Bill Casts", type: .cast)
                        
                        trailerRow(videos: details.videos)
 
                        PosterRow(results: details.recommendations?.results, title: "Recommendations", type: .movie)
                        
                        PosterRow(results: details.similar?.results, title: "Similar", type: .movie)
                        
                        seasonRow(seasons: details.seasons?.reversed(), proxy: proxy)
                        
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle(details.title)
            .navigationBarTitleDisplayMode(.inline)
            
            
        } else {
            ProgressView()
        }
    }
}

extension MediaDetailsView{
    @ViewBuilder
    func backDrop(name:String, width: CGFloat) -> some View {
        let path = "https://image.tmdb.org/t/p/w500/\(name)"
        BackdropImg(url: path, width: width)
    }
   
    
    @ViewBuilder
    func poster(details: DetailsWrapper, proxy: GeometryProxy, isPresented: Binding<Bool>) -> some View {
        let path:String = "https://image.tmdb.org/t/p/w500/\(details.poster ?? "")"
        let width:CGFloat = 110
        let height:CGFloat = 180
    
        HStack{
            Img(url: path, width: width, height: height)
                .shadow(radius: 2)
                .sheet(isPresented: $isPresented) {
                    ZStack{
                        Img(url:"https://image.tmdb.org/t/p/original/\(details.poster ?? "")" , width: proxy.size.width, height: proxy.size.height)
                        DismissSheetButton(isPresented: $isPresented)
                            .padding()
                    }
                }
                .onTapGesture {
                    isPresented.wrappedValue.toggle()
                }
       
            VStack(alignment: .leading){
               
                Text(details.title)
                    .font(.title2)
                    .bold()
                    .padding(.vertical,2)
                Text(details.date)
                    .bold()
                    .padding(.vertical,1)
                Text(details.status ?? "")
                    .foregroundColor(.gray)
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    
    @ViewBuilder
    func tagline(details: DetailsWrapper) -> some View {
        if !details.tagline.isEmpty {
            HStack{
                Text("\"\(details.tagline)\"")
                    .italic()
                    .padding(.horizontal)
                    .padding(.bottom, 3)
                Spacer()
            }
           
        } else {
            Text("")
        }
    }
    
    
    @ViewBuilder
    func overview(details: DetailsWrapper) -> some View {
        VStack (alignment: .leading){
            if !details.overview.isEmpty {
                Text("Overview")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)


                Text(details.overview)
                    .lineLimit(isExpanded ? .max : 8)
                    .onTapGesture {
                        isExpanded.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)

            }
        }
    }
    
    
    @ViewBuilder
    func trailerRow(videos: Videos?) -> some View {

        if videos?.results.count ?? 0 > 0 {
            VStack(alignment: .leading, spacing: .zero){
                
                Text("Trailers")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                
                ScrollView (.horizontal){
                    HStack{
                        ForEach(videos?.results.prefix(5) ?? [], id: \.id) { video in
                            WebView(url: "https://www.youtube.com/embed/\(video.key ?? "")")
                                .frame(width: 320, height: 200)
                                .cornerRadius(10)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .padding(.bottom, 10)
        }     
    }
    
    @ViewBuilder
    func seasonRow(seasons: [Season]?, proxy:GeometryProxy) -> some View {

        if let seasons = seasons, seasons.count > 0 {
            VStack (alignment: .leading, spacing: 10){
                Group{
                    Text("Seasons")
                        .font(.title2)
                        .bold()
                    if let season = seasons.first {
                        seasonCard(season: season, height: 220)
                    }
                }
                .padding(.horizontal)
                
                
                if seasons.count > 1 {
                    ScrollView(.horizontal){
                        HStack (spacing: 13){
                            ForEach(seasons, id: \.id){ season in
                                seasonCard(season: season, width: 270, height: 180)
                            }
                        }
                        .padding(.horizontal)

                    
                    }
                    .frame(height: 180)
                    .padding(.top, 3)

                }
                
            }
        }
        
    }
    
    @ViewBuilder
    func seasonCard(season: Season, width: CGFloat? = nil, height: CGFloat) -> some View {
        let baseUrl = "https://image.tmdb.org/t/p/w500/"

        GeometryReader{ proxy in
            
            Img(
                url: "\(baseUrl)\(season.posterPath ?? "")",
                width: proxy.frame(in: .local).width,
                height: proxy.frame(in: .local).height,
                mode: .fill,
                alignment: .top

            )
            
            
            .overlay (
                ZStack (alignment: .bottomLeading){
                    
                    LinearGradient(colors: [.clear, .black.opacity(0.5), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    VStack (alignment: .leading){
                        Text(season.name ?? "")
                            .font(.title2)
                            .bold()
                        HStack{
                            Text((season.episodeCount?.description ?? "") + " Episodes")
                            Text(" | ")
                            Text(MyDateTools.format(this: season.airDate ?? ""))
                        }
                        .bold()
                       
                    }
                    .padding()
                    .foregroundColor(.white)
                }
            )
            .cornerRadius(10)

        }
        .frame(width:width, height:height)
       
        
        
    }
    

}

struct MediaDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MediaDetailsView(id: 13, type: .movie)
    }
}
