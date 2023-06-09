//
//  ErrorResponse.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation


struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    enum CodingKeys:String, CodingKey{
        case code = "status_code", message = "status_message"
    }
}
