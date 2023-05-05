//
//  LearnMoreViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/30/23.
//

import UIKit

class LearnMoreViewController: UIViewController {
    
    let eventImageView = UIImageView()
    let eventNameLabel = UILabel()
    let eventLocationLabel = UILabel()
    let eventTimeLabel = UILabel()
    let eventHostLabel = UILabel()
    let descriptionTextView = UITextView()
    let deleteButton = UIButton()
    
    var currentUser: User = User(username: "udp3", password: "Password", email: "udp3@cornell.edu" , name: "Deepa Pulugurtha")
    
    var event: Event
    
    init(event: Event, user: User) {
        self.currentUser = user
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white

        //TODO fill in more here
        
        
        view.backgroundColor = UIColor(named: "CollectionViewBackground")

        eventImageView.image = UIImage(named: event.category + "Event")
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 5
        view.addSubview(eventImageView)
        
        eventNameLabel.text = event.title
        eventNameLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        eventNameLabel.textColor = .white
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventNameLabel)
        
        eventLocationLabel.text = event.address
        eventLocationLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.02)
        eventLocationLabel.textColor = .white
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventLocationLabel)
        
        eventTimeLabel.text = event.start
        eventTimeLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.025)
        eventTimeLabel.textColor = .white
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventTimeLabel)
        
        eventHostLabel.text = event.host
        eventHostLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.025)
        eventHostLabel.textColor = .white
        eventHostLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventHostLabel)
        
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont(name: "Helvetica", size: view.frame.height * 0.02)
        descriptionTextView.backgroundColor = UIColor(named: "ButtonColor")
        descriptionTextView.textColor = .white
        descriptionTextView.text = event.description
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("delete Event", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = UIColor(named: "ButtonColor")
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 3
        deleteButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.02)
        deleteButton.isHidden = true
        if eventHostLabel.text == self.currentUser.name{
            deleteButton.isHidden = false
        }
        
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        //deleteButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        view.addSubview(deleteButton)
        //TODO add hyperlink functionality to this button

        setupConstraints()
    }
    
    @objc func deleteAction() {

        NetworkManager.shared.deleteEvent(id: self.event.id)
        HomeViewController.shared.setupVCs()
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            eventImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 3/6),
            eventImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10),
            eventNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            eventLocationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 10),
            eventLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            eventTimeLabel.topAnchor.constraint(equalTo: eventLocationLabel.bottomAnchor, constant: 10),
            eventTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            eventHostLabel.topAnchor.constraint(equalTo: eventTimeLabel.bottomAnchor, constant: 10),
            eventHostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: eventHostLabel.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
