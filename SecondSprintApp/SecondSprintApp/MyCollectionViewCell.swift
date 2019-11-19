//
//  MyCollectionViewCell.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 12/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import MobileCoreServices

class MyCollectionViewCell: UICollectionViewCell {
    public static let reuseId = "dkjsf"
    
    let boardData = TrelloBoardDataManagerSingleton.shared
//    var expandedLabel: UILabel!
    var indexOfCellToExpand = -1
    
    var tableView = UITableView()
    weak var parentVC: TasksScreenViewController?
    public var updateButton = UIButton()
    
    var board: Board?
//    public let label = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let footer: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
                    button.setTitle("+ Добавить еще одну карточку", for:  .normal)
                    button.titleLabel?.font = .systemFont(ofSize: 14)
                    button.backgroundColor = .lightGray
                    button.setTitleColor(.black, for: .normal)
                    button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
                    return button
        }()

        tableView.frame = CGRect(x:0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(tableView)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        tableView.backgroundColor = .gray
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseId)
        tableView.dragInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footer
        print("WOW")
        awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
/*
    override func awakeFromNib() {
        super.awakeFromNib()
        let footer: UIButton = {
            let button = UIButton()
            button.setTitle("+ Добавить еще одну карточку", for:  .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.backgroundColor = .lightGray
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0

        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseId)
        tableView.tableFooterView = footer
        footer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        footer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        footer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    */
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseId, for: indexPath) as! MyTableViewCell
        let task =  board?.items[indexPath.row]
//        cell.backgroundColor = .white
//        cell.nameLabel.text = task
        cell.textLabel?.text = task
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyCollectionViewCell: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let board = board, let stringData = board.items[indexPath.row].data(using: .utf8) else {
            return []
        }
        print("itemsForBeginning")
        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (board, indexPath, tableView)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        self.parentVC?.setupRemoveBarButtonItem()
        self.parentVC?.navigationItem.rightBarButtonItem = nil
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        self.parentVC?.setupAddButtonItem()
        self.parentVC?.navigationItem.leftBarButtonItem = nil
    }
    
}

extension MyCollectionViewCell: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let string = items.first as? String else {
                    return
                }
                
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    let updatedIndexPaths: [IndexPath]
                    if sourceIndexPath.row < destinationIndexPath.row {
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else {
                        updatedIndexPaths = []
                    }
                    self.tableView.beginUpdates()
                    self.board?.items.remove(at: sourceIndexPath.row)
                    self.board?.items.insert(string, at: destinationIndexPath.row)
                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.items.insert(string, at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.items.append(string)
                    self.tableView.insertRows(at: [IndexPath(row: self.board!.items.count - 1 , section: 0)], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                default: break
                    
                }
            }
        }
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.items.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
