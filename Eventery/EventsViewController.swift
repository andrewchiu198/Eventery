//
//  EventsViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class EventsViewController: UIViewController {
    
    let label = UILabel()
    var interestsCollectionView: UICollectionView!
    var eventsCollectionView: UICollectionView!
    var interestsTypes = ["Sports", "Business", "Social", "Art"]
    var activatedInterests = ["","","",""]
    
    let events = DummyData.events
    
    var filteredEvents = DummyData.events
    
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 15
    let cellReuseID = "cellReuseID"
    let interestsReuseID = "interestReuseID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        let interestsFlowLayout = UICollectionViewFlowLayout()
        interestsFlowLayout.minimumLineSpacing = itemPadding
        interestsFlowLayout.minimumInteritemSpacing = itemPadding
        interestsFlowLayout.scrollDirection = .horizontal
        interestsFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        interestsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: interestsFlowLayout)
        interestsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        interestsCollectionView.register(InterestsCollectionViewCell.self, forCellWithReuseIdentifier: interestsReuseID)
        interestsCollectionView.dataSource = self
        interestsCollectionView.delegate = self
        interestsCollectionView.tag = 0
        interestsCollectionView.backgroundColor = UIColor(named: "InterestsBackgroundColor")
        interestsCollectionView.layer.cornerRadius = 10
        interestsCollectionView.clipsToBounds = true
        interestsCollectionView.layer.borderWidth = 3
        interestsCollectionView.layer.borderColor = UIColor(white: 0, alpha: 0.1).cgColor
        view.addSubview(interestsCollectionView)
        
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
        eventsCollectionView.backgroundColor = UIColor(named: "CollectionViewBackground")
        eventsCollectionView.layer.cornerRadius = 10
        eventsCollectionView.clipsToBounds = true
        view.addSubview(eventsCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            interestsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            interestsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            interestsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            interestsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: interestsCollectionView.bottomAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            eventsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func filterData() {
        filteredEvents = []
        //TODO add case for all de-activated
    
        for event in events {
            for interest in activatedInterests {
                if(event.tags[0] == interest) {
                    filteredEvents.append(event)
                }
            }
        }
        
        if activatedInterests == ["","","",""] {
            filteredEvents = events
        }
    }
}

extension EventsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let cell:UICollectionViewCell = interestsCollectionView.cellForItem(at: indexPath)!
            
            
            if (cell.tag == 0) {
                cell.contentView.backgroundColor = UIColor(named: "SelectedColor")
                cell.tag = 1
                
                var allEmpty = true
                
                for act in activatedInterests {
                    if(act != "") {
                        allEmpty = false
                    }
                }
                
                if(allEmpty == true) {
                    activatedInterests = ["","","",""]
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
                
                activatedInterests[indexPath.row] = selection
            }
            
            else {
                cell.contentView.backgroundColor = UIColor(named: "ButtonColor")
                cell.tag = 0
                activatedInterests[indexPath.row] = ""
            }
            
            print(activatedInterests)
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
            return interestsTypes.count
        }
        if collectionView.tag == 1 {
            return filteredEvents.count
        }
        return 0
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestsReuseID, for: indexPath) as? InterestsCollectionViewCell {
                cell.configureCell(interest: interestsTypes[indexPath.row])
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
            return CGSize(width: view.frame.width/2.5, height: view.frame.height/20)
        }
        if collectionView.tag == 1 {
            return CGSize(width: view.frame.width/2.25, height: view.frame.width/2.25)
        }
        return CGSize()
    }
}
