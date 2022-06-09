//
//  FavoriteController.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

class FavoriteController{
    private weak var view: FavoriteView!
    
    private var model: FavoriteModel?
    
    init(view: FavoriteView!) {
        self.view = view
        self.model = FavoriteModel(controller: self)
    }
    
    func collectionViewReloaded(){
        view.reloadCollection()
    }
    
    func checkFavorites(){
        model?.checkFavorites()
    }
    
    func getFavorite(index: Int) -> Product{
        return (model?.getFavorite(index: index))!
    }
    
    func getCount() -> Int{
        return (model?.getCount())!
    }
}
