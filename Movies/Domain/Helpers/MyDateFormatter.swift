//
//  MyDateFormater.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 19/6/23.
//

import Foundation


class MyDateFormatter {
    static let dateFormatter = DateFormatter()
  

    static func format(this date: String) -> String{
        MyDateFormatter.dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd MMM yyyy"
            let formattedDate = dateFormatter.string(from: date)
            return ("\(formattedDate)") // Output: 22 Jul 1947
        } else {
            return(date)
        }
    }
   
}
