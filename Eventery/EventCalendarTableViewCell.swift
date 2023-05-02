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
        
        name.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(name)
        contentView.addSubview(time)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //    func updateFrom(brush: Brush){
    //        name.text = brush.brushName
    //        size.text = String(brush.brushSize)
    //        color.backgroundColor = brush.brushColor
    //    }
    
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
