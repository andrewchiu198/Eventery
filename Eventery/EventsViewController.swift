//
//  EventsViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class EventsViewController: UIViewController {
    // TODO: make pretty
    
    let label = UILabel()
    var categoriesCollectionView: UICollectionView!
    var eventsCollectionView: UICollectionView!
    var categoryTypes = Categories.categories
    
    var activatedCategories = ["", "", "", ""]
    
    let refreshControl = UIRefreshControl()
    
    var events: [Event]
    var filteredEvents: [Event] = []
    var user: User
    
    init(events: [Event], user: User) {
        self.events = events
        self.filteredEvents = events
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 15
    let cellReuseID = "cellReuseID"
    let categoriesReuseID = "categoriesReuseID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        let categoriesFlowLayout = UICollectionViewFlowLayout()
        categoriesFlowLayout.minimumLineSpacing = itemPadding
        categoriesFlowLayout.minimumInteritemSpacing = itemPadding
        categoriesFlowLayout.scrollDirection = .horizontal
        categoriesFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesFlowLayout)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: categoriesReuseID)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .systemBackground
        categoriesCollectionView.tag = 0
        categoriesCollectionView.clipsToBounds = true
        categoriesCollectionView.flashScrollIndicators()
        view.addSubview(categoriesCollectionView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        
        eventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        eventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        eventsCollectionView.register(EventsCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        eventsCollectionView.dataSource = self
        eventsCollectionView.delegate = self
        eventsCollectionView.tag = 1
        eventsCollectionView.backgroundColor = .systemBackground
        view.addSubview(eventsCollectionView)
        
        NetworkManager.shared.getAllEvents { events in
            DispatchQueue.main.async {
                self.events = events
            }
        }
        
        if #available(iOS 10.0, *) {
            eventsCollectionView.refreshControl = refreshControl
        } else {
            eventsCollectionView.addSubview(refreshControl)
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            eventsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func refreshData() {
        NetworkManager.shared.getAllEvents { events in
            DispatchQueue.main.async {
                self.filteredEvents = events
                self.eventsCollectionView.reloadData()
                // print("reloaded")
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func filterData() {
        filteredEvents = []
        for event in events {
            for category in activatedCategories {
                if event.category == category {
                    filteredEvents.append(event)
                }
            }
        }
        
        if activatedCategories == ["", "", "", ""] {
            filteredEvents = events
        }
    }
}

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let cell: EventsCollectionViewCell = eventsCollectionView.cellForItem(at: indexPath) as! EventsCollectionViewCell
            let vc = LearnMoreViewController(event: cell.event, user: user)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if collectionView.tag == 0 {
            let cell: UICollectionViewCell = categoriesCollectionView.cellForItem(at: indexPath)!
            
            if cell.tag == 0 {
                cell.contentView.backgroundColor = vermilion
                cell.tag = 1
                
                var allEmpty = true
                
                for act in activatedCategories {
                    if act != "" {
                        allEmpty = false
                    }
                }
                
                if allEmpty == true {
                    activatedCategories = ["", "", "", ""]
                }
                
                var selection: String
                switch indexPath.row {
                case 0:
                    selection = "Sports"
                case 1:
                    selection = "Business"
                case 2:
                    selection = "Social"
                case 3:
                    selection = "Art"
                default:
                    selection = ""
                }
                
                activatedCategories[indexPath.row] = selection
            } else {
                cell.contentView.backgroundColor = carnellian
                cell.tag = 0
                activatedCategories[indexPath.row] = ""
            }
            filterData()
            eventsCollectionView.reloadData()
        }
    }
}

extension EventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return categoryTypes.count
        }
        if collectionView.tag == 1 {
            return filteredEvents.count
        }
        return 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesReuseID, for: indexPath) as? CategoriesCollectionViewCell {
                cell.configureCell(category: categoryTypes[indexPath.row])
                return cell
            }
        }
        if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? EventsCollectionViewCell {
                cell.parent = self
                cell.configureCell(event: filteredEvents[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: view.frame.width/2.5, height: view.frame.height/27)
        }
        if collectionView.tag == 1 {
            return CGSize(width: view.frame.width/2.25, height: view.frame.width/2.25)
        }
        return CGSize()
    }
}
