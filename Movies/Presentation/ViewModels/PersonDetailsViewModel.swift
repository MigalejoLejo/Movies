//
//  PersonDetailsViewModel.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import Foundation


class PersonDetailsViewModel: ObservableObject {
    var id: Int = 0
    var endpoint:String = ""
    var params: [String:Any] = [:]

    @Published var person: PeopleDetails? = nil
  
    
    
    func loadDetails(id:Int){
        self.id = id
        endpoint = "person/\(id)"
        params = ["append_to_response": "combined_credits,images"]

        ApiService.get(endpoint: endpoint, parameters: params){ (person: PeopleDetails) in
            self.person = person

           
        }
       
        
    }
    
}
