//
//  EventsCollectionViewCell.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .placeholderText
        
        setupConstraints()
        
    
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
