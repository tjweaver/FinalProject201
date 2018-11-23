//
//  TabBarViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var nameOfuser: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        print(nameOfuser)
        //let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        //UITabBar.appearance().barTintColor = darkPurple // your color
        UITabBar.appearance().backgroundColor = UIColor.clear
        UITabBar.appearance().tintColor = UIColor.white

        self.tabBarController?.tabBar.items?[0].title = "Explore"
        self.tabBarController?.tabBar.items?[1].title = "Search"
        self.tabBarController?.tabBar.items?[2].title = "Profile"
        self.tabBarController?.tabBar.items?[3].title = "Player"

        /*
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Explore, tag: 0)
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Search, tag: 1)
        let userVC = ProfileViewController()
        userVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Profile, tag: 2)
        
*/
        self.tabBarController?.tabBar.items?[0].image = UIImage(named: "compact-disc")
        self.tabBarController?.tabBar.items?[1].image = UIImage(named: "search")
        self.tabBarController?.tabBar.items?[2].image = UIImage(named: "user")
        self.tabBarController?.tabBar.items?[3].image = UIImage(named: "play-button")

        // Do any additional setup after loading the view.
    }
    
    func setUpTabBar()
    {
        //let exploreVC = UINavigationController(rootViewController: ExploreViewController)
        //exploreVC.tabBarItem.image = UIImage(named: "compact-disc)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
