//
//  ViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        tabBar.backgroundColor = UIColor(named: "TabBarColor")
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.separator.cgColor
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = UIColor(named: "HighlightColor")
        setupVCs()
    }
        
        func setupVCs() {
            viewControllers = [
                createNavController(for: EventsViewController(), title: NSLocalizedString("Events", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
                
                createNavController(for: CalendarViewController(), title: NSLocalizedString("Calendar", comment: ""), image: UIImage(systemName: "calendar")!),
                
                createNavController(for: MapViewController(), title: NSLocalizedString("Map", comment: ""), image: UIImage(systemName: "map.fill")!),
                
                createNavController(for: PostViewController(), title: NSLocalizedString("Post", comment: ""), image: UIImage(systemName: "square.and.pencil")!),
                
                createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person.fill")!),
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
}

