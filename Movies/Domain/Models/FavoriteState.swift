//
//  FavoriteState.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 29/6/23.
//

import Foundation


struct FavoriteState: Codable {
    var media_type: String
    var media_id: Int
    var favorite: Bool
    
    enum codingKeys: String, CodingKey{
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
    
    
    
}
