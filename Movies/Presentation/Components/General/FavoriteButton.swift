//
//  FavoriteButton.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 29/6/23.
//

import SwiftUI

struct FavoriteButton: View {
    var isFavorite:Bool
    var removeFavorite:()->()
    var addFavorite:()->()
    
    var body: some View {
        if isFavorite {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.yellow)
                
                .onTapGesture {
                    removeFavorite()
                }
            
        } else {
            Image(systemName: "star")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.gray)
                .onTapGesture {
                    addFavorite()
                }
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    @State static var isFavorite = true
    @State static var removeFavorite: ()->() = {print("removed from favorites")}
    @State static var addFavorites: ()->() = {print("added to favorites")}
    
    static var previews: some View {
        FavoriteButton(isFavorite: isFavorite, removeFavorite: removeFavorite, addFavorite: addFavorites)
    }
}
