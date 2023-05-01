//
//  InterestsCollectionViewCell.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    
    let interestsLabel = UILabel()
    var interest = ""
        
    weak var parent: EventsViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = 0
        contentView.backgroundColor = UIColor(named: "ButtonColor")
        contentView.layer.cornerRadius = 3
        contentView.clipsToBounds = true
        interestsLabel.text = interest
        interestsLabel.textColor = .white
        interestsLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.65)
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(interestsLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            interestsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            interestsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(interest: String) {
        self.interest = interest
        interestsLabel.text = interest
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
