//
//  DataManager.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

class DataManager{
    
    static let shared = DataManager()
    
    private var favorites = [Product]()
    
    func addFavorite(_ item: Product){
        favorites.append(item)
    }
    
    func getFavorite(index: Int) -> Product{
        return favorites[index]
    }
    
    func getFavoritesCount()->Int{
        return favorites.count
    }
    
}
