//
//  CalendarCell.swift
//  Eventery
//
//  Created by Quinn Hulme on 5/2/23.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    let dayOfTheMonth = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dayOfTheMonth.layer.cornerRadius = 5
        dayOfTheMonth.clipsToBounds = true
        dayOfTheMonth.textAlignment = .center
        
        dayOfTheMonth.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayOfTheMonth)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            dayOfTheMonth.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfTheMonth.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//            dayOfTheMonth.topAnchor.constraint(equalTo: contentView.topAnchor),
//            dayOfTheMonth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            dayOfTheMonth.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            dayOfTheMonth.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func update(date: Int) {
        dayOfTheMonth.text = String(date)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
