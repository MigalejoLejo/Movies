//
//  MediaDetailsViewViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 14/6/23.
//

import Foundation
import CodableX


//
//  MainViewVM.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 12/6/23.
//

import SwiftUI

class MediaDetailsViewModel: ObservableObject {
    var id: Int
    var type: ResultType
    
    var endpoint:String = ""
    
    @Published var mediaDetails: MediaDetails? = nil
    
    init(id: Int, type: ResultType) {
        self.id = id
        self.type = type
        loadDetails()
    }
    
    func loadDetails(){
        var params: [String:Any] = [:]
        endpoint = "\(type)/\(id)"
        
        params = ["append_to_response": "similar,recommendations,credits,videos"]
        if type == .movie {
            ApiService.get(endpoint: endpoint, parameters: params){ (mediaDetails: MovieDetails) in
                self.mediaDetails = mediaDetails
            }
        }
        if type == .tv{
            ApiService.get(endpoint: endpoint, parameters: params){ (mediaDetails: TVDetails) in
                self.mediaDetails = mediaDetails
                
            }
        }
        
        guard let details = mediaDetails else {
            return
        }
        self.mediaDetails = details
        print("calling api: ")
        print(self.mediaDetails?.details.title ?? "")
        
    }
    
    func getVideos(id:String){
        let params: [String:Any] = [:]
       
        endpoint = "\(type)/\(id)/videos"
        ApiService.get(endpoint: endpoint, parameters: params){ (videos: Videos) in
         
        }
        
    }
}
