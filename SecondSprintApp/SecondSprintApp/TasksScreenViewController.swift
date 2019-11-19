//
//  TasksScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import MobileCoreServices

class TasksScreenViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

    let layout = UICollectionViewFlowLayout()
    
//    var collectionView: UICollectionView!
    
    var boards: [Board] = []
    
    var data = TrelloBoardDataManagerSingleton.shared
    
    var downloadLabel: UILabel!
    
    var planet: UIView!
    var spaceship: UIView!
    var secondSpaceship: UIView!
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "task"), tag: 1)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "task"), tag: 1)
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
    
    func setupRemoveBarButtonItem() {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addInteraction(UIDropInteraction(delegate: self))
        let removeBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = removeBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.async {
            self.downloadAnimation()
            self.downloadLabel.fadeTransition(1.0)
            self.downloadLabel.text = self.downloadLabel.text! + "."
            self.downloadLabel.fadeTransition(1.0)
            self.downloadLabel.text = self.downloadLabel.text! + "."
            self.downloadLabel.fadeTransition(1.0)
            self.downloadLabel.text = self.downloadLabel.text! + "."
            UIView.animate(withDuration: 3.5) {
                self.planet.alpha = 0.0
                self.spaceship.alpha = 0.0
                self.secondSpaceship.alpha = 0.0
                self.downloadLabel.alpha = 0.0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
            print("\(self.data.list![0].id)")
            
            let list = self.data.list ?? []
            let cards = self.data.cards ?? []
            for item in list {
                let newBoard = Board()
                newBoard.title = item.name
                for card in cards where item.id == card.idList {
                    newBoard.items.append(card.desc)
                }
                self.boards.append(newBoard)
            }
            
            self.layout.scrollDirection = .horizontal
            self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.layout)
            self.collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 20, right: 40)
            self.collectionView.backgroundColor = .gray
            self.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseId)
//            self.view.addSubview(self.collectionView)
            
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            self.updateCollectionViewItem(with: self.view.bounds.size)
        })
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        awakeFromNib()
        self.tabBarController?.navigationItem.title = "Добавить список"
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

    func downloadAnimation() {
        
        downloadLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 40))
        downloadLabel.font = .boldSystemFont(ofSize: 20)
        downloadLabel.text = "Downloading"
        downloadLabel.textAlignment = .center
        downloadLabel.center = view.center
        downloadLabel.center.y += 200
        downloadLabel.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(downloadLabel)
        
        planet = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        planet.center = view.center
        planet.layer.contents = UIImage(named: "redplanet")?.cgImage
        planet.tag = 101
        view.backgroundColor = .white
        view.addSubview(planet)
        planet.backgroundColor = .red
        planet.layer.cornerRadius = 50
        
        spaceship = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        spaceship.tag = 102
        spaceship.layer.contents = UIImage(named: "spaceship2")?.cgImage
        
        planet.layer.zPosition = 100
        spaceship.layer.zPosition = 80
        //let zPosPath = "position.z"
        //        let anima = CABasicAnimation(keyPath: zPosPath)
        //        anima.fromValue = spaceShip.layer.zPosition
        //        anima.toValue = planet.layer.zPosition + 2000
        //        anima.duration = 2.3
        spaceship.backgroundColor = .clear
        let orbitBounds = CGRect(x: planet.center.x - 160, y: planet.center.y - 80, width: 320, height: 160)
        orbitBounds.applying(CGAffineTransform(rotationAngle: .pi / 5))
        
        let orbit = CAKeyframeAnimation(keyPath: "position")
        orbit.path = CGPath(ellipseIn: orbitBounds, transform: nil)
        orbit.duration = 4.0
        orbit.rotationMode = .rotateAuto
        orbit.calculationMode = .cubicPaced
        orbit.repeatCount = 3
        orbit.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]
        orbit.isAdditive = false
        orbit.fillMode = .forwards
        orbit.isRemovedOnCompletion = false
        
        secondSpaceship = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        secondSpaceship.tag = 103
        secondSpaceship.layer.contents = UIImage(named: "spaceship4")?.cgImage
        secondSpaceship.layer.zPosition = 120
        secondSpaceship.backgroundColor = .clear
        let secondOrbit = CAKeyframeAnimation(keyPath: "position")
        let secondOrbitPath = UIBezierPath()
        secondOrbitPath.move(to: CGPoint(x: view.center.x, y: view.center.y - 400))
        secondOrbitPath.addQuadCurve(to: CGPoint(x: view.center.x + 20, y: view.center.y - 230), controlPoint: CGPoint(x: view.center.x - 160, y: view.center.y + 300))
        secondOrbitPath.addQuadCurve(to: CGPoint(x: view.center.x, y: view.center.y - 400), controlPoint: CGPoint(x: view.center.x - 170, y: view.center.y - 200))
        secondOrbit.path = secondOrbitPath.cgPath
        secondOrbit.duration = 4.0
        secondOrbit.rotationMode = .rotateAutoReverse
        secondOrbit.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]
        secondOrbit.repeatCount = 3
        
        secondSpaceship.layer.add(secondOrbit, forKey: "secondOrbit")
        spaceship.layer.add(orbit, forKey: "orbit")
        //spaceShip.layer.add(anima, forKey: "zPosPath")
        view.addSubview(spaceship)
        view.addSubview(secondSpaceship)
        
        
        UIView.animate(withDuration: 4.0,
                       delay: 0.0,
                       options: [.curveLinear],
                       animations: {
                        self.spaceship.layer.zPosition *= 2
                        self.spaceship.layer.zPosition *= 0.5
        }, completion: { _ in
            
        })
        
        UIView.animate(withDuration: 4.0,
                       delay: 0.1,
                       options: [.curveEaseInOut],
                       animations: {
                        self.spaceship.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.spaceship.transform = CGAffineTransform(scaleX: 2/5, y: 2/5)
        },
                       completion: { _ in
                        
        })
        
        UIView.animate(withDuration: 4.0,
                       delay: 0.1,
                       options: [.curveEaseInOut],
                       animations: {
                       self.secondSpaceship.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                       self.secondSpaceship.transform = CGAffineTransform(scaleX: 2/5, y: 2/5)
        },
                       completion: { _ in
                        
        })

    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseId, for: indexPath) as! MyCollectionViewCell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseId, for: indexPath) as! MyCollectionViewCell
        cell.setup(with: boards[indexPath.row])
        cell.parentVC = self
        return cell
        
    }
}

//extension TasksScreenViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseId, for: indexPath) as! MyCollectionViewCell
//    }
//}

/*
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
*/
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

extension TasksScreenViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            session.loadObjects(ofClass: NSString.self) { (items) in
                guard let _ = items.first as? String else {
                    return
                }
                
                if let (dataSource, sourceIndexPath, tableView) = session.localDragSession?.localContext as? (Board, IndexPath, UITableView) {
                    tableView.beginUpdates()
                    dataSource.items.remove(at: sourceIndexPath.row)
                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                    tableView.endUpdates()
                }
            }
        }
    }
}
