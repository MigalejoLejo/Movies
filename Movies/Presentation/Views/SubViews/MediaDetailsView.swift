//
//  MediaDetailsView.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import SwiftUI
import Kingfisher
import MovieData


struct MediaDetailsView: View {
    
    @EnvironmentObject var contentViewModel:ContentViewModel
    @ObservedObject var model: MediaDetailsViewModel
    
    @State private var isExpanded:Bool = false
    @State private var isPresented = false
    @State private var updateView = false
    
    
    
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
                        
                        PosterRow(results: details.credits.castResults , title: "top_bill_cast".localizedLanguage(), type: .cast)
                        
                        trailerRow(videos: details.videos)
                        
                        PosterRow(results: details.recommendations?.results, title: "recommendations".localizedLanguage(), type: .movie)
                        
                        PosterRow(results: details.similar?.results, title: "Similar".localizedLanguage(), type: .movie)
                        
                        seasonRow(seasons: details.seasons?.reversed(), proxy: proxy)
                        
                    }
                    .onDisappear{
                        if updateView {
                            UserService.sharedInstance.updateFavorites.toggle()
                            updateView = false
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle(details.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        contentViewModel.navToHome()
                    } label: {
                        Image(systemName: "house")
                    }
                }
            }
            .onChange(of:model.isFavorite) { value in
                updateView.toggle()
            }
            
            
        } else {
            LottieView(name: "loading")
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
                        SheetImage(url: "https://image.tmdb.org/t/p/original/\(details.poster ?? "")")
                        DismissSheetButton(isPresented: $isPresented)
                            .padding()
                    }
                    .background(.black)

                }
                .onTapGesture {
                    isPresented.wrappedValue.toggle()
                }
            
            VStack(alignment: .leading){
                HStack (alignment: .top){
                    Text(details.title)
                        .font(.title2)
                        .bold()
                        .padding(.vertical,2)
                    Spacer()
                    FavoriteButton(
                        isFavorite: model.isFavorite,
                        removeFavorite: {
                            model.remove()
                        }, addFavorite: {
                            model.add()
                        })
                    
                }
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
                Text("overview".localizedLanguage())
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
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
                Text("trailers".localizedLanguage())
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                ScrollView (.horizontal){
                    HStack{
                        ForEach(videos?.results.prefix(5) ?? [], id: \.id) { video in
                            WebView(url: "https://www.youtube.com/embed/\(video.key ?? "")")
                                .frame(width: 320, height: 200)
                                .cornerRadius(10)
                        }
                    }.padding(.horizontal)
                }
            }.padding(.bottom, 10)
        }
    }
    
    
    @ViewBuilder
    func seasonRow(seasons: [Season]?, proxy:GeometryProxy) -> some View {
        if let seasons = seasons, seasons.count > 0 {
            VStack (alignment: .leading, spacing: 10){
                Group{
                    Text("Seasons".localizedLanguage())
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
                            Text((season.episodeCount?.description ?? "") + " \("episodes".localizedLanguage())")
                            Text(" | ")
                            Text(DateTools.format(this: season.airDate ?? ""))
                        }.bold()
                    }
                    .padding()
                    .foregroundColor(.white)
                }
            ).cornerRadius(10)
        } .frame(width:width, height:height)
    }
    
//    
//    func addToFavorites(){
//        updateView = true
//    }
//    
//    func removeFromFavorites() {
//        updateView = false
//    }
    
    
}

struct MediaDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        MediaDetailsView(id: 13, type: .movie)
            .environmentObject(ContentViewModel())
    }
}
