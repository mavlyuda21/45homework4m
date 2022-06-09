//
//  DataManager.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation

protocol ProductsDownloaded: AnyObject{
    func productsDownloaded()
}

class DataManager{
    
    static let shared = DataManager()
    
    private var networkManager = NetworkManager()

    private var products = [Product]()
    
    private var favorites = [Product]()
    
    weak var delegate: ProductsDownloaded?
    
    func downloadProducts(delegate: ProductsDownloaded){
        self.delegate = delegate
        networkManager.downloadProducts { array in
            self.products = array
            delegate.productsDownloaded()
        }
    }
    
    func getCount() -> Int{
        return products.count
    }
    
    func getProduct(index: Int) -> Product{
        return products[index]
    }
    
    func getFiltered(text: String) -> [Product]{
        return products.filter({ $0.title.lowercased().contains(text.lowercased()) })
    }
    
    func addFavorite(index: Int){
        favorites.append(products[index])
        UserDefaults.standard.set(true, forKey: products[index].title)
    }
    
    func checkFavorites(){
        favorites.removeAll()
        for i in products{
            if UserDefaults.standard.bool(forKey: i.title) == true{
                favorites.append(i)
            }
        }
    }
    
    func getFavorite(index: Int) -> Product{
        return favorites[index]
    }
    
    func getFavoritesCount()->Int{
        return favorites.count
    }
    
}
