//
//  UserService.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 6/6/23.
//

import Foundation
import KeychainAccess

class UserService: ObservableObject {
   
    static var sharedInstance: UserService = .init()
    private var storage: Keychain = .init(service: "com.miguelcorrea.Movie")
    
    @Published var sessionID: String? = nil
    @Published var isLoggedIn: Bool = false
    
    public var hasSessionID: Bool {
        guard let _ = try? storage.get("session_id") else {
            return false
        }
        return true
    }
  
    
    init() {
        loadSessionID()
        isLoggedIn = hasSessionID

    }
    
    
    func loadSessionID (){
        if let storageSessionID = try? storage.get("session_id") {
            sessionID = storageSessionID
            isLoggedIn = hasSessionID
        } else {
            sessionID = nil
            isLoggedIn = hasSessionID

        }
    }
    
    
    
    func authenticate (username: String, password: String, errorCallback: ((ErrorResponse?)->Void)? = nil, successCallback: (()->Void)? = nil){
        newToken{ token in
            let credentials: UserCredentials = .init(username: username, password: password, requestToken: token.requestToken)
            ApiService.post(endpoint: "authentication/token/validate_with_login", body: credentials, callback: { (responseToken:Token) in
                if token.success {
                    self.newSession(requestToken: responseToken.requestToken , errorCallback: errorCallback)
                }
            }, errorCallback: errorCallback)
        }
    }
     
    private func newToken (done: @escaping (Token)-> Void){
        ApiService.get(endpoint: "authentication/token/new") { (token:Token) in
            if token.success {
                done(token)
            }
        }
    }
    
    
    
    func newSession (requestToken:String, errorCallback: ((ErrorResponse?)->Void)?, successCallback: (()->Void)? = nil){
        let credentials: TokenCredential = .init(requestToken: requestToken)
        ApiService.post(endpoint: "authentication/session/new", body: credentials, callback: { (session:Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionID, key: "session_id")
                    self.loadSessionID()
                    successCallback?()
                } catch (let error){
                    print("On creating new session: " + error.localizedDescription)
                }
            }
        }, errorCallback: errorCallback)
    }
    
    
    
    func unauthenticate (){
        loadSessionID()
        let credentials: SessionCredential = .init(sessionID:sessionID ?? "")
        ApiService.delete(endpoint: "authentication/session", body: credentials, callback: { (result:LogoutResponse) in
            if  result.success {
                do {
                    try self.storage.remove("session_id")
                    self.loadSessionID()
                } catch (let error){
                    print("On unauthentication: " + error.localizedDescription)
                }
            }
        })
    }
}
