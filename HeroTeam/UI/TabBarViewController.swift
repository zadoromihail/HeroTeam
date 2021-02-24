//
//  TabBarViewController.swift
//  HeroTeam
//
//  Created by Михаил Задорожный on 19.02.2021.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        reloadTabs()
    }
    
    private func reloadTabs() {
        viewControllers = [homeNC, storedVC]
    }
    
    private var homeNC: UINavigationController {
        let vc = HomeViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        return nc
    }

    private var storedVC: UINavigationController {
        let vc = StoredTeamsViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(title: "Stored teams", image: UIImage(named: "folder"), tag: 1)
        return nc
    }
}
