//
//  NotesScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit


class Notes: CustomStringConvertible {
    var notes: [String] = []
    var noteCount: Int {
        return notes.count
    }

    var description: String {
        return notes.description
    }
    
    init() {
    }
    
    public func addNote(withText text: String) {
        notes.append(text)
    }
    
    subscript(index: Int) -> String {
        return notes[index]
    }
}

final class NoteSingleton {
    static let shared = NoteSingleton()
    
    var notes = Notes()
    private init() {
        
    }
}

class NotesScreenViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var selectedIndex: Int = -1
    
    
    private func setupNavigationBarForNotes() {
        setupNoteBtn()
    }
      
    func setupNoteBtn() {
        let noteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onNewNoteButtonTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = noteButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        //self.title = "Notes"
        
        // Do any additional setup after loading the view.
//        let title = UIBarButtonItem(title: "Notes: \(noteNum)", style: .plain, target: self, action: #selector(barTitle))
         // you will probably need to move it into viewWillAppear

        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MySecondTableViewCell.self, forCellReuseIdentifier: "notesCell")
    }
    

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "note"), tag: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    func onNewNoteButtonTapped(){
        navigationController?.pushViewController(NotesEditorScreenViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let satellite1 = UIView()
        let satellite2 = UIView()
        let satellite3 = UIView()
        
        let orbit1 = CAKeyframeAnimation(keyPath: "position")
        let orbit2 = CAKeyframeAnimation(keyPath: "position")
        let orbit3 = CAKeyframeAnimation(keyPath: "position")
        
        let orbitBounds1 = CGRect(x: 125, y: 125, width: 150, height: 150)
        let orbitBounds2 = CGRect(x: 175, y: 175, width: 50, height: 50)
        let orbitBounds3 = CGRect(x: 150, y: 150, width: 100, height: 100)
        
        let image1 = UIImage(named: "earth")
        let imageView1 = UIImageView(image: image1)
        imageView1.frame = CGRect(x: 200, y: 200, width: 20, height: 20)
        
        let image2 = UIImage(named: "satellite")
        let imageView2 = UIImageView(image: image2)
        imageView2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let imageView3 = UIImageView(image: image2)
        imageView3.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let imageView4 = UIImageView(image: image2)
        imageView4.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        view.addSubview(imageView1)
        
        orbit1.path = CGPath(ellipseIn: orbitBounds1, transform: nil)
        orbit2.path = CGPath(ellipseIn: orbitBounds2, transform: nil)
        orbit3.path = CGPath(ellipseIn: orbitBounds3, transform: nil)
        
        orbit1.duration = 4.8
        orbit1.isAdditive = true
        orbit1.repeatCount = HUGE
        orbit1.calculationMode = .paced
        
        
        orbit2.duration = 5
        orbit2.isAdditive = true
        orbit2.repeatCount = HUGE
        orbit2.calculationMode = .paced
        
        orbit3.duration = 4.9
        orbit3.isAdditive = true
        orbit3.repeatCount = HUGE
        orbit3.calculationMode = .paced
        
        satellite1.addSubview(imageView2)
        satellite2.addSubview(imageView4)
        satellite3.addSubview(imageView3)
        
        view.addSubview(satellite1)
        view.addSubview(satellite2)
        view.addSubview(satellite3)
        satellite1.layer.add(orbit1,forKey: "orbit1")
        satellite2.layer.add(orbit2,forKey: "orbit2")
        satellite3.layer.add(orbit3,forKey: "orbit3" )

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Notes (\(NoteSingleton.shared.notes.noteCount))"
        navigationController?.isNavigationBarHidden = false
        setupNavigationBarForNotes()
        tableView.reloadData()
    }
}


extension NotesScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if NoteSingleton.shared.notes.noteCount == 0 { return 0 }
        return NoteSingleton.shared.notes.noteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MySecondTableViewCell.reuseIdOfCell, for: indexPath) as! MySecondTableViewCell
        cell.nameLabelSecond.text = NoteSingleton.shared.notes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == selectedIndex {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            return UITableView.automaticDimension
        }
        return 100
    }
    
    
}



class MySecondTableViewCell: UITableViewCell {

    public static let reuseIdOfCell = "notesCell"
    
    public let nameLabelSecond = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabelSecond.frame = self.contentView.frame
        nameLabelSecond.center = self.contentView.center
        nameLabelSecond.textAlignment = .left
        nameLabelSecond.font = .systemFont(ofSize: 20)
        nameLabelSecond.numberOfLines = 0
        
        
        contentView.addSubview(nameLabelSecond)
        nameLabelSecond.translatesAutoresizingMaskIntoConstraints = false
        nameLabelSecond.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        nameLabelSecond.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        nameLabelSecond.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameLabelSecond.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        nameLabelSecond.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
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
