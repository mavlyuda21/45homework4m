//
//  FavoriteModel.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

class FavoriteModel{
    private weak var controller: FavoriteController!
    
    init(controller: FavoriteController!) {
        self.controller = controller
        controller.collectionViewReloaded()
    }
    
    func getFavorite(index: Int) -> Product{
        return DataManager.shared.getFavorite(index: index)
    }
    
    func getCount() -> Int{
        return DataManager.shared.getFavoritesCount()
    }
}
