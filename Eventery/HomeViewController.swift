//
//  HomeViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class HomeViewController: UITabBarController {
    
    //let refreshControl = UIRefreshControl()
    
    var events = DummyData.events

    override func viewDidLoad() {
        
        var url = URL(string: "https://34.85.172.228")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        tabBar.backgroundColor = UIColor(named: "TabBarColor")
        tabBar.layer.borderWidth = 1
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = UIColor.separator.cgColor
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = UIColor(named: "HighlightColor")
        setupVCs()
        
    }
        
        func setupVCs() {
            viewControllers = [
                createNavController(for: EventsViewController(events: events), title: NSLocalizedString("Events", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
                
                createNavController(for: CalendarViewController(), title: NSLocalizedString("Calendar", comment: ""), image: UIImage(systemName: "calendar")!),
                
                createNavController(for: MapViewController(events: events), title: NSLocalizedString("Map", comment: ""), image: UIImage(systemName: "map.fill")!),
                
                createNavController(for: PostViewController(), title: NSLocalizedString("Post", comment: ""), image: UIImage(systemName: "square.and.pencil")!),
                
                createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person.fill")!),
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 22) as Any
            ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        rootViewController.navigationItem.title = title
        return navController
    }
    
//    @objc func refreshData() {
//
//            NetworkManager.shared.getAllEvents { events in
//                DispatchQueue.main.async {
//                    self.events = events
//                    //self.messageTableView.reloadData()
//                    self.refreshControl.endRefreshing()
//                }
//            }
//
//    }
    
}

