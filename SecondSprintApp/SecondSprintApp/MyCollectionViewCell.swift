//
//  MyCollectionViewCell.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 12/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    public static let reuseId = "dkjsf"
    
    let boardData = TrelloBoardDataManagerSingleton.shared
//    var expandedLabel: UILabel!
    var indexOfCellToExpand = -1
    
    var tableView = UITableView()
    weak var parentVC: TasksScreenViewController?
    public var updateButton = UIButton()
    
    var board: Board?
    public let label = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        let footer: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            button.setTitle("+ Добавить еще одну карточку", for:  .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.backgroundColor = .lightGray
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            return button
        }()
        self.backgroundColor = .white
        label.frame = contentView.frame
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        tableView.frame = CGRect(x:0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(tableView)
//        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseId)
        tableView.tableFooterView = footer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addTapped() {
        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let data = self.board else {
                return
            }
            
            data.items.append(text)
            var id = ""
            for lists in self.boardData.list! where lists.name == data.title {
                id = lists.id
            }
            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
            let card = TrelloCard(name: "New card", desc: text, idList: id)
            self.boardData.addCard(card)
            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        parentVC?.present(alertController, animated: true, completion: nil)
    }
    
    func setup(with data: Board) {
        self.board = data
        tableView.reloadData()
    }

}

extension MyCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return board?.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseId, for: indexPath) as! MyTableViewCell
        let task =  board?.items[indexPath.row]
        cell.backgroundColor = .white
//        cell.layer.cornerRadius = 10
        cell.nameLabel.text = task
//        cell.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == indexOfCellToExpand{
            indexOfCellToExpand = -1
        } else {
            indexOfCellToExpand = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == indexOfCellToExpand {
            return UITableView.automaticDimension
        }
        return 100
    }
    
    
    
}
