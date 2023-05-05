//
//  CategoriesCollectionViewCell.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/1/23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    let categoryLabel = UILabel()
    var category = ""
        
    weak var parent: EventsViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = 0
        contentView.backgroundColor = UIColor(named: "ButtonColor")
        contentView.layer.cornerRadius = 3
        contentView.clipsToBounds = true
        categoryLabel.text = category
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont(name: "Helvetica-Bold", size: contentView.frame.height * 0.6)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(category: String) {
        self.category = category
        categoryLabel.text = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
