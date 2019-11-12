//
//  TasksScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class TasksScreenViewController: UIViewController {

    let layout = UICollectionViewFlowLayout()
    
    var collectionView: UICollectionView!
    
    var boards: [Board] = []
    

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "task"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    private func setupNavigationBar() {
        setupAddButtonItem()
    }
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
    }
    
    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButtonItem
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        boards.append(Board(title: "Нужно сделать", items: ["LASKDJASKLDJASKLASJDKLASJDKSJKLDLASDJKLASDJKLASJDKASJDKLASJDKLASJDKLASDJKALSDJAKSDJASKLDJAKSLDJKALSDJKLASDJKALSDJAKSDJASKDJAKSDJKAJDAJDASLKDAJSLKDJASKLDJASKLDJKALSJDKLASJDKLASDJKLASDJSKLDJKASDJAKSLDJKASLDJAKSLDJASKLDASKLDJASKLDJKDJAKDJASKDASJDKASJDASKDASJKDKASLDJAKSDJKLDJKASLDJKALSDJASKDJASKDJKASDJKLASJKLASJKDASKDAKSJLDJADKLASDJAKLDASJKDAD", "Schema Design", "Storage Management", "Model Abstraction"]))
        boards.append(Board(title: "В процессе", items: ["LASKDJASKLDJASKLASJDKLASJDKSJKLDLASDJKLASDJKLASJDKASJDKLASJDKLASJDKLASDJKALSDJAKSDJASKLDJAKSLDJKALSDJKLASDJKALSDJAKSDJASKDJAKSDJKAJDAJDASLKDAJSLKDJASKLDJASKLDJKALSJDKLASJDKLASDJKLASDJSKLDJKASDJAKSLDJKASLDJAKSLDJASKLDASKLDJASKLDJKDJAKDJASKDASJDKASJDASKDASJKDKASLDJAKSDJKLDJKASLDJKALSDJASKDJASKDJKASDJKLASJKLASJKDASKDAKSJLDJADKLASDJAKLDASJKDAD", "Schema Design", "Storage Management", "Model Abstraction"]))
        boards.append(Board(title: "Готово", items: ["LASKDJASKLDJASKLASJDKLASJDKSJKLDLASDJKLASDJKLASJDKASJDKLASJDKLASJDKLASDJKALSDJAKSDJASKLDJAKSLDJKALSDJKLASDJKALSDJAKSDJASKDJAKSDJKAJDAJDASLKDAJSLKDJASKLDJASKLDJKALSJDKLASJDKLASDJKLASDJSKLDJKASDJAKSLDJKASLDJAKSLDJASKLDASKLDJASKLDJKDJAKDJASKDASJDKASJDASKDASJKDKASLDJAKSDJKLDJKASLDJKALSDJASKDJASKDJKASDJKLASJKLASJKDASKDAKSJLDJADKLASDJAKLDASJKDAD", "Schema Design", "Storage Management", "Model Abstraction"]))
        
        //        layout.itemSize = CGSize(width: 200, height: view.frame.height - 100)
        //        layout.minimumInteritemSpacing = 100
        //        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 20, right: 40)
        collectionView.backgroundColor = .gray
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseId)
        view.addSubview(collectionView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavigationBar()
        updateCollectionViewItem(with: view.bounds.size)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    func addListTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить список", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            self.boards.append(Board(title: text, items: []))
            
            let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
            
            self.collectionView.insertItems(at: [addedIndexPath])
            self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

}

extension TasksScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseId, for: indexPath) as! MyCollectionViewCell
    }
}

extension TasksScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseId, for: indexPath) as! MyCollectionViewCell
        
        cell.setup(with: boards[indexPath.row])
        cell.parentVC = self
        
        return cell
        
    }
    
    
}
