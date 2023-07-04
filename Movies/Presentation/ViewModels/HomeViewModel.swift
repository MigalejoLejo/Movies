//
//  MainViewVM.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 12/6/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var rows:[HomeRow] = []
    @Published var hasFinishedLoading = true
    
    var endpoints:[Endpoint] = []
    
    func setEndpoints(){
        endpoints = [
            Endpoint(path: "movie/popular", title: "popular_movies".localizedLanguage()),
            Endpoint(path: "movie/top_rated", title:"top_rated_movies".localizedLanguage()),
            Endpoint(path: "movie/upcoming", title: "upcoming".localizedLanguage()),
            Endpoint(path: "person/popular", title: "popular_people".localizedLanguage()),
            Endpoint(path: "tv/airing_today", title: "airing_today".localizedLanguage()),
            Endpoint(path: "tv/popular", title: "popular_tv_series".localizedLanguage()),
            Endpoint(path: "tv/top_rated", title: "top_rated_tv".localizedLanguage()),
            Endpoint(path: "trending/all/week", title: "trending_now".localizedLanguage()),
        ]
    }
    
   
    func logout() {
        UserService.sharedInstance.unauthenticate()
    }
    
    func fetchLists() {
        if rows.isEmpty{
            hasFinishedLoading = false
            setEndpoints()
            var count = 0
            
            let params:[String:Any] = [
                "language":UserService.sharedInstance.appLanguage
            ]
        
            
            for endpoint in endpoints {
                ApiService.get(endpoint: endpoint.path, parameters: params){ (resultList:ResultList) in
                    self.rows.append(.init(title: endpoint.title, list: resultList, params: endpoint.params, endpoint: endpoint.path))
                }
                count += 1
                
                if count == endpoints.count-1 {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.hasFinishedLoading = true
                        
                    }
                }
            }
        }
    }
    
    
    
    func reload(){
        rows = []
    }
}

