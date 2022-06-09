//
//  MainModel.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

class MainModel{
    private weak var controller: MainController!

    private var filtered = [Product]()
    
    init(controller: MainController!) {
        self.controller = controller
    }
    
    func downloadProducts(){
        DataManager.shared.downloadProducts(delegate: self)
        self.controller.collectionViewReloaded()
    }
    
    func getCount() -> Int{
        return DataManager.shared.getCount()
    }
    
    func addFavorites(index: IndexPath){
        DataManager.shared.addFavorite(index: index.row)
    }
    
    func getFilteredCount() -> Int{
        return filtered.count
    }
    
    func getFiltered() -> [Product]{
        return filtered
    }
    
    func textChange(_ text: String){
        filtered = DataManager.shared.getFiltered(text: text)
        self.controller.collectionViewReloaded()
    }
    
    func getProduct(index: Int) -> Product{
        return DataManager.shared.getProduct(index: index)
    }
}

extension MainModel: ProductsDownloaded{
    func productsDownloaded() {
        self.controller.collectionViewReloaded()
    }
}
