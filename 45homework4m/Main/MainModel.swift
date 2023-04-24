//
//  MainModel.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

class MainModel{
    private weak var controller: MainController!
    
    private var networkManager = NetworkManager()

    private var products = [Product]()

    private var filtered = [Product]()
    
    init(controller: MainController!) {
        self.controller = controller
    }
    
    func downloadProducts(){
        networkManager.downloadProducts { result in
            self.products = result
            self.controller.collectionViewReloaded()
        }
    }
    
    func addFavorites(index: IndexPath){
        DataManager.shared.addFavorite(products[index.row])
    }
    
    func getFilteredCount() -> Int{
        return filtered.count
    }
    
    func getFiltered() -> [Product]{
        return filtered
    }
    
    func textChange(_ text: String){
        filtered = products.filter({ $0.title.lowercased().contains(text.lowercased()) })
        self.controller.collectionViewReloaded()
    }
    
    func getProducts() -> [Product]{
        return products
    }
}
