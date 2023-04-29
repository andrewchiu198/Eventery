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

    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 15
    let cellReuseID = "cellReuseID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        eventsCollectionView.backgroundColor = .placeholderText
        eventsCollectionView.layer.cornerRadius = 10
        eventsCollectionView.clipsToBounds = true
        view.addSubview(eventsCollectionView)
        
        let filterFlowLayout = UICollectionViewFlowLayout()
        filterFlowLayout.minimumLineSpacing = itemPadding
        filterFlowLayout.minimumInteritemSpacing = itemPadding
        filterFlowLayout.scrollDirection = .horizontal
        filterFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        setupConstraints()
        
        
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            eventsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension EventsViewController: UICollectionViewDelegate {
    
}

extension EventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? EventsCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.3, height: view.frame.width/2.3)
    }
}
