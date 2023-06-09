//
//  Token.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 7/6/23.
//

import Foundation

struct Token: Codable{
    var success: Bool
    var expirationDate: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey{
        case success
        case expirationDate =  "expires_at"
        case requestToken = "request_token"
    }
}


struct UserCredentials: Codable {
    var username: String
    var password: String
    var requestToken: String
    
    enum CodingKeys:String, CodingKey{
        case username, password, requestToken = "request_token"
    }
}


struct TokenCredential: Codable {
    var requestToken: String

    enum CodingKeys:String, CodingKey{
        case requestToken = "request_token"
    }
}


struct SessionCredential: Codable {
    var sessionID: String

    enum CodingKeys:String, CodingKey{
        case sessionID = "session_id"
    }
}

struct Session:Codable {
    var success: Bool
    var sessionID: String

    enum CodingKeys:String, CodingKey{
        case success, sessionID = "session_id"
    }
}

struct LogoutResponse: Codable {
    var success: Bool
}
