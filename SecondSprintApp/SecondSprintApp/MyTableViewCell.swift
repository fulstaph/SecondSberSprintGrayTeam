//
//  MyTableViewCell.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 12/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    public static let reuseId = "dkjsf"
    
    public let nameLabel = UILabel()
//    public var nameLabelisChecked = false
    var indexOfCellToExpand: Int!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.frame = self.contentView.frame
        nameLabel.center = self.contentView.center
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }
    
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
