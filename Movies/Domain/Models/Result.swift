//
//  Result.swift
//  Movie
//
//  Created by Miguel Alejandro Correa Avila on 5/6/23.
//

import Foundation



struct Result: Identifiable, Hashable {
    let uuid = UUID()
    let id:Int
    let title:String
    let subtitle:String?
    let image:String
    let type:ResultType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}

