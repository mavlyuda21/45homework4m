//
//  MainController.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

class MainController{
    private weak var view: MainView!
    
    private var model: MainModel?
    
    init(view: MainView!) {
        self.view = view
        self.model = MainModel(controller: self)
    }
    
    func downloadProducts(){
        model?.downloadProducts()
    }
    
    func getProducts(_ array: [Product]){
        view.reloadCollection()
    }
    
    func getFilteredCount() -> Int{
        return (model?.getFilteredCount())!
    }
    
    func getCount() -> Int{
        return (model?.getCount())!
    }
    
    func getFiltered() -> [Product]{
        return (model?.getFiltered())!
    }
    
    func collectionViewReloaded(){
        view.reloadCollection()
    }
    
    func heartTapped(index: IndexPath){
        model?.addFavorites(index: index)
    }
    
    func textChange(_ text: String){
        model?.textChange(text)
    }
    
    func getProduct(index: Int) -> Product{
        let products = model?.getProduct(index: index)
        return products!
    }
}
