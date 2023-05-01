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
    let eventTimeLabel = UILabel()
    let learnMoreButton = UIButton()
    
    var event = Event(id: 0, title: "Event Name", address: "Event Location", start: "00/00/0000 00:00p.m.", end: "00/00/0000p.m.", description: "Default", host: "DefaultHost", host_email: "SomeEmail", image: "ArtEvent", free: true, attendees: [""], tags: [""])
    
    weak var parent: EventsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "CellColor")
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        eventImageView.image = UIImage(named: event.image)
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 5
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventImageView)
        
        eventNameLabel.text = event.title
        eventNameLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.08)
        eventNameLabel.textColor = .white
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventNameLabel)
        
        eventLocationLabel.text = event.address
        eventLocationLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.06)
        eventLocationLabel.textColor = .white
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventLocationLabel)
     
        eventTimeLabel.text = event.start
        eventTimeLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.06)
        eventTimeLabel.textColor = .white
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventTimeLabel)
        
        learnMoreButton.setTitle("Learn More", for: .normal)
        learnMoreButton.setTitleColor(.white, for: .normal)
        learnMoreButton.translatesAutoresizingMaskIntoConstraints = false
        learnMoreButton.backgroundColor = UIColor(named: "ButtonColor")
        learnMoreButton.clipsToBounds = true
        learnMoreButton.layer.cornerRadius = 3
        learnMoreButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.09)
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonClicked), for: .touchUpInside)
        learnMoreButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        contentView.addSubview(learnMoreButton)
        
        setupConstraints()
        
    }
    
    @objc func learnMoreButtonClicked() {
        let vc = LearnMoreViewController(event: event)
        parent?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCell(event: Event) {
        self.event = event
        eventImageView.image = UIImage(named: event.image)
        eventNameLabel.text = event.title
        eventLocationLabel.text = event.address
        eventTimeLabel.text = event.start
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            eventImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 3/6),
            eventImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 5),
            eventNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            eventLocationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 5),
            eventLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            eventTimeLabel.topAnchor.constraint(equalTo: eventLocationLabel.bottomAnchor, constant: 5),
            eventTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            learnMoreButton.topAnchor.constraint(equalTo: eventTimeLabel.bottomAnchor, constant: 5),
            learnMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            learnMoreButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
