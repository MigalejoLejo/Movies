//
//  MediaDetailsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import SwiftUI
import YouTubePlayerKit

struct MediaDetailsView: View {
    
    @ObservedObject var model: MediaDetailsViewModel
    @State var isExpanded:Bool = false
    
    init(id: Int, type: ResultType){
        model = MediaDetailsViewModel(id: id, type: type)
    }
    
    var body: some View {
        if let details = model.mediaDetails?.details{
            GeometryReader{ proxy in
                ScrollView ( .vertical ) {
                    VStack (alignment: .center, spacing: .zero) {
                        
                        backDrop(name: details.backdrop ?? "", width: proxy.size.width)
                        
                        Group{
                            poster(details:details)
                            tagline(details: details)
                            overview(details: details)
                        }
                        
                        PosterRow(results: details.credits.castResults , title: "Top Bill Casts", type: .cast)
                        
                        trailerRow(videos: details.videos)
 
                        PosterRow(results: details.recommendations?.results, title: "Recommendations", type: .movie)
                        
                        PosterRow(results: details.similar?.results, title: "Similar", type: .movie)
                        
                        seasonRow(seasons: details.seasons)
                        
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
    func poster(details: DetailsWrapper) -> some View {
        let path:String = "https://image.tmdb.org/t/p/w500/\(details.poster ?? "")"
        let width:CGFloat = 110
        let height:CGFloat = 180
    
        HStack{
            Img(url: path, width: width, height: height)
                .shadow(radius: 2)
       
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
    func seasonRow(seasons: [Season]?) -> some View {
        if let seasons = seasons, seasons.count > 0 {
            Text("Seasons")
        }
        
        
    }
    
    @ViewBuilder
    func seassonCard(seasons: [Season], width: CGFloat, height: CGFloat) -> some View {}
    

}

struct MediaDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MediaDetailsView(id: 13, type: .movie)
    }
}
