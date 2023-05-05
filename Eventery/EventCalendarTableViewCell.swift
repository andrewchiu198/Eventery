//
//  EventCalendarTableViewCell.swift
//  Eventery
//
//  Created by Quinn Hulme on 5/2/23.
//

import UIKit

class EventCalendarTableViewCell: UITableViewCell {
    let name = UILabel()
    
    let time = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name.textColor = .label
        name.font = UIFont(name: "Helvetica", size: 18)
        
        time.textColor = carnellian
        time.font = UIFont(name: "Helvetica-Bold", size: 14)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(name)
        contentView.addSubview(time)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            time.topAnchor.constraint(equalTo: name.bottomAnchor)
        ])
    }
    
    func updateFrom(title: String, date: String) {
        name.text = title
        time.text = date
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
