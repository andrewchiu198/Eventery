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
    let freeLabel = UILabel()
    
    var currentUser: User = User(id: 9089809, name: "udp3", netid: "udp3@cornell.edu", email: "Deepa Pulugurtha")
    
    var event: Event
    
    init(event: Event, user: User) {
        self.currentUser = user
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = carnellian
        UITabBar.appearance().isTranslucent = false
        navigationController?.navigationBar.tintColor = carnellian

        // TODO: fill in more here
        
        view.backgroundColor = .systemBackground

        if let e = event.category {
            eventImageView.image = UIImage(named: e + "Event")

        }
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 5
        view.addSubview(eventImageView)
        
        if(event.free == false) {
            freeLabel.backgroundColor = .red
        }
        else {
            freeLabel.backgroundColor = .green
        }
        freeLabel.translatesAutoresizingMaskIntoConstraints = false
        freeLabel.layer.cornerRadius = 5
        freeLabel.clipsToBounds = true
        freeLabel.textColor = .white
        freeLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.width * 0.04)
        freeLabel.textColor = .white
        freeLabel.textAlignment = .center
        freeLabel.text = "Free"
        view.addSubview(freeLabel)
        
        
        eventNameLabel.text = event.title
        eventNameLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        eventNameLabel.textColor = .label
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventNameLabel)
        
        eventLocationLabel.text = event.address
        eventLocationLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.02)
        eventLocationLabel.textColor = carnellian
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventLocationLabel)
        
        eventTimeLabel.text = event.start
        eventTimeLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.025)
        eventTimeLabel.textColor = carnellian
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventTimeLabel)
        
        eventHostLabel.text = event.host
        eventHostLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.025)
        eventHostLabel.textColor = carnellian
        eventHostLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventHostLabel)
        
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont(name: "Helvetica", size: view.frame.height * 0.02)
        descriptionTextView.backgroundColor = .systemBackground
        descriptionTextView.textColor = .label
        descriptionTextView.text = event.description
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("delete Event", for: .normal)
        deleteButton.setTitleColor(carnellian, for: .normal)
        deleteButton.backgroundColor = .secondarySystemBackground
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 3
        deleteButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.02)
        deleteButton.isHidden = true
        if eventHostLabel.text == currentUser.name {
            deleteButton.isHidden = false
        }
        
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        // deleteButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        view.addSubview(deleteButton)
        setupConstraints()
    }
    
    @objc func deleteAction() {
        NetworkManager.shared.deleteEvent(id: event.id)
        HomeViewController.shared.setupVCs()
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 3 / 6),
            eventImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10),
            eventNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventNameLabel.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width)
        ])
        
        NSLayoutConstraint.activate([
            eventLocationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 10),
            eventLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            eventLocationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventLocationLabel.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width)
        ])
        
        NSLayoutConstraint.activate([
            eventTimeLabel.topAnchor.constraint(equalTo: eventLocationLabel.bottomAnchor, constant: 10),
            eventTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            eventTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventTimeLabel.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width)
        ])
        
        NSLayoutConstraint.activate([
            eventHostLabel.topAnchor.constraint(equalTo: eventTimeLabel.bottomAnchor, constant: 10),
            eventHostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            eventHostLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventHostLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: eventHostLabel.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            freeLabel.topAnchor.constraint(equalTo: eventTimeLabel.bottomAnchor, constant: 10),
            freeLabel.leadingAnchor.constraint(equalTo: eventHostLabel.trailingAnchor, constant: 20),
            freeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            freeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
