//
//  EventsCollectionViewCell.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    let eventImageView = UIImageView()
    let eventNameLabel = UILabel()
    let eventLocationLabel = UILabel()
    let startTimeLabel = UILabel()
    let freeLabel = UILabel()
//    let learnMoreButton = UIButton()
    
    var event = Event(id: 0, title: "", address: "", start: "", end: "", description: "", host: "", host_email: "", free: false, category: "")
    
    weak var parent: EventsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        if let e = event.category {
            eventImageView.image = UIImage(named: e + "Event")
        }
        
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
        freeLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width * 0.065)
        freeLabel.textAlignment = .center
        freeLabel.text = "Free"
        
        
        contentView.addSubview(freeLabel)
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 5
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventImageView)
        
        eventNameLabel.text = event.title
        eventNameLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width * 0.1)
        eventNameLabel.textColor = .label
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventNameLabel)
        
        eventLocationLabel.text = event.address
        eventLocationLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width * 0.06)
        eventLocationLabel.textColor = .secondaryLabel
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventLocationLabel)
     
        startTimeLabel.text = event.start
        startTimeLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.width * 0.06)
        startTimeLabel.textColor = .secondaryLabel
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(startTimeLabel)
        
//        learnMoreButton.setTitle("Learn More", for: .normal)
//        learnMoreButton.setTitleColor(.white, for: .normal)
//        learnMoreButton.translatesAutoresizingMaskIntoConstraints = false
//        learnMoreButton.backgroundColor = UIColor(named: "ButtonColor")
//        learnMoreButton.clipsToBounds = true
//        learnMoreButton.layer.cornerRadius = 3
//        learnMoreButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.07)
//        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonClicked), for: .touchUpInside)
//        learnMoreButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
//        contentView.addSubview(learnMoreButton)
//
        setupConstraints()
    }
    
    @objc func learnMoreButtonClicked() {
        let vc = LearnMoreViewController(event: event, user: parent!.user)
        parent?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCell(event: Event) {
        self.event = event
        if let e = event.category {
            eventImageView.image = UIImage(named: e + "Event")

        }
        eventNameLabel.text = event.title
        eventLocationLabel.text = event.address
        startTimeLabel.text = event.start
        
        if(event.free == false) {
            freeLabel.backgroundColor = .red
        }
        else {
            freeLabel.backgroundColor = .green
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            eventImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 3 / 6),
            eventImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 5),
            eventNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            eventLocationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 5),
            eventLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            startTimeLabel.topAnchor.constraint(equalTo: eventLocationLabel.bottomAnchor, constant: 5),
            startTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            //            learnMoreButton.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 5),
//            learnMoreButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            freeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 10),
            freeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            freeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier:  0.3),
            freeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
