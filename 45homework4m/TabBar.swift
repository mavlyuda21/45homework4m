//
//  TabBar.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation
import UIKit

class TabBar: UITabBarController{
    override func viewDidLoad() {
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers () {
        let mainViewController = MainView()
        let favouriteViewController = FavoriteView()
        let mainIcon = UIImage(systemName: "house.fill")
        let favouriteIcon = UIImage(systemName: "heart")
        
        viewControllers = [generateNavigatonController(rootViewController: mainViewController, image: mainIcon!),generateNavigatonController(rootViewController: favouriteViewController, image: favouriteIcon!)]
        }
    
    func generateNavigatonController(rootViewController:
                                      UIViewController, image: UIImage) -> UIViewController{
        let navigationController =
        UINavigationController(rootViewController:
                                rootViewController)
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
