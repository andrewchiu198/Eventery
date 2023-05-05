//
//  HomeViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class HomeViewController: UITabBarController {
    
    //let refreshControl = UIRefreshControl()
    
    static let shared = HomeViewController()
    
    var events: [Event] = []
    
    var user: User = User(username: "udp3", password: "Password", email: "udp3@cornell.edu", name: "Deepa Pulugurtha")
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        var url = URL(string: "https://34.85.177.184")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        
        selectedIndex = 0

        
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
            
            NetworkManager.shared.getAllEvents { events in
                DispatchQueue.main.async {
                    self.events = events
                    
                    self.viewControllers = [
                        self.createNavController(for: EventsViewController(events: self.events, user: self.user), title: NSLocalizedString("Events", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
                        
                        self.createNavController(for: CalendarViewController(events: self.events), title: NSLocalizedString("Calendar", comment: ""), image: UIImage(systemName: "calendar")!),
                        
                        self.createNavController(for: MapViewController(events: self.events), title: NSLocalizedString("Map", comment: ""), image: UIImage(systemName: "map.fill")!),
                        
                        self.createNavController(for: PostViewController(), title: NSLocalizedString("Post", comment: ""), image: UIImage(systemName: "square.and.pencil")!),
                        
                        self.createNavController(for: ProfileViewController(user: self.user), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person.fill")!),
                ]
                    
                }
            }
    }
    
    func setUser(user: User){
        
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

