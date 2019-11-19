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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel!.center = self.contentView.center
        textLabel!.textAlignment = .center
        textLabel!.font = .systemFont(ofSize: 20)
        textLabel!.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

