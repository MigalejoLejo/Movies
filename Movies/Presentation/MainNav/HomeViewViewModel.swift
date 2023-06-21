//
//  MainViewVM.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 12/6/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var rows:[HomeRow] = []
    
    var endpoints:[Endpoint] = [
        Endpoint(path: "movie/popular", title: "Popular Movies"),
        Endpoint(path: "movie/top_rated", title: "Top Rated Movies"),
        Endpoint(path: "movie/upcoming", title: "Upcoming Movies"),
        Endpoint(path: "person/popular", title: "Popular People"),
        Endpoint(path: "tv/airing_today", title: "Airing Today"),
        Endpoint(path: "tv/popular", title: "Popular TV Series"),
        Endpoint(path: "tv/top_rated", title: "Top Rated TV"),
        Endpoint(path: "trending/all/week", title: "Trending now"),
      
    
    ]
    
   
    func logout() {
        UserService.sharedInstance.unauthenticate()
    }
    
    func fetchLists() {
        for endpoint in endpoints {
            ApiService.get(endpoint: endpoint.path){ (resultList:ResultList) in
               
                self.rows.append(.init(title: endpoint.title, list: resultList, params: endpoint.params, endpoint: endpoint.path))
            }
        }
    }
}

