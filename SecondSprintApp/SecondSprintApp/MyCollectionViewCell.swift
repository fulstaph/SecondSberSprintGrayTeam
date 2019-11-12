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
    
    
    var tableView = UITableView()
    weak var parentVC: TasksScreenViewController?
    public var updateButton = UIButton()
    
    var board: Board?
    public let label = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        label.frame = contentView.frame
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        updateButton = UIButton(frame: CGRect(x: 0, y: 5, width: contentView.frame.width, height: 40))
        updateButton.setTitle("Добавить", for:  .normal)
        updateButton.backgroundColor = .darkGray
        updateButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        tableView.frame = CGRect(x: 0, y: 55, width: contentView.frame.width, height: contentView.frame.height - 55)
        
        contentView.addSubview(updateButton)
        contentView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseId)
        
        
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
            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
            
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
        cell.nameLabel.text = task
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
}
