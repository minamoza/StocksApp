//
//  ModuleBuilder.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 29.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    static let shared: ModuleBuilder = .init()
    
    func networkService() -> NetworkService {
        network
    }
    
    func stocksService() -> StocksServiceProtocol {
        StocksService(client: network)
    }
    
    func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService())
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    func secondVC() -> UIViewController {
        UIViewController()
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: .add, tag: 0)
        
        let secondVC = secondVC()
        secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 2)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 2)
        
        tabbar.viewControllers = [stocksVC, secondVC, thirdVC]
        
        return tabbar
    }
}
