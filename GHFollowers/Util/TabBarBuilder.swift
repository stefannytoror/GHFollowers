//
//  Configurator.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 22/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import UIKit

enum TabBarItem {
    case search
    case favorites
}

struct TabBarBuilder {
    static func createItem(type: TabBarItem) -> UINavigationController {
        let vc: UIViewController
        switch type {
        case .search:
            vc = SearchViewController()
            vc.title = "Search"
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        default:
            vc = FavoritesViewController()
            vc.title = "Favorites"
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        }

        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.tintColor = .systemGreen
        return navController
    }
}
