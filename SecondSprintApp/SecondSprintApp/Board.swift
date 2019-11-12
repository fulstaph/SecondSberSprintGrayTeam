//
//  Board.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 12/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

class Board: Codable {
    var title: String
    var items: [String]
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
}
