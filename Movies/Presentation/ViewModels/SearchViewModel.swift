//
//  SearchViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 20/6/23.
//

import Foundation


class SearchViewModel: ObservableObject {
 
    var params: [String:Any] = [:]
    
    @Published var results: [Result] = []
    var page:Int = -1
    var totalPages:Int = 1
    var item: String = ""
    var category: String = ""
    var endpoint:String = ""
    
    
    func search(item: String, in category:String){
        params = ["query": item]
        self.item = item
        self.category = category
        endpoint = "search/\(category)"

        ApiService.get(endpoint: endpoint, parameters: params){ (resultList: ResultList) in
            self.results = resultList.results
            self.totalPages = resultList.totalPages ?? 0
        }
        page = 0
    }
    
    func getMoreResults(){
        page += 1
        params = ["query": item, "page": page]
       
    

        if page <= totalPages {
            ApiService.get(endpoint:endpoint, parameters: params ){ (resultList:ResultList) in
                self.results.append(contentsOf: resultList.results)
            }
        }
    }
    
}
