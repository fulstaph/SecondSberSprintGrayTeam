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
    var images: [UIImage] = []
    var noteCount: Int {
        return notes.count
    }

    var description: String {
        return notes.description
    }
    
    init() {
    }
    
    public func addNote(withText text: String, withImage image: UIImage) {
        notes.append(text)
        images.append(image)
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
 
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        indicator.backgroundColor = .lightGray
        indicator.layer.cornerRadius = 3
        indicator.style = .white
        indicator.color = .white
        return indicator
    }()
    
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
        tableView.beginUpdates()
        cell.textOfNote.text = NoteSingleton.shared.notes.notes[indexPath.row]
        cell.containerForImage.setImage(NoteSingleton.shared.notes.images[indexPath.row], for: .normal)
        tableView.endUpdates()
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
    
    public let textOfNote = UILabel()
//    public let imageOfNote = UIImage()
    public let containerForImage = UIButton()
  
//    let containerForImage: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        view.backgroundColor = .red
//        return view
//    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerForImage.backgroundColor = .lightGray
        containerForImage.clipsToBounds = true
        textOfNote.textAlignment = .left
        textOfNote.font = .systemFont(ofSize: 20)
        textOfNote.numberOfLines = 0
        
        contentView.addSubview(textOfNote)
        contentView.addSubview(containerForImage)

        
        containerForImage.translatesAutoresizingMaskIntoConstraints = false
        textOfNote.translatesAutoresizingMaskIntoConstraints = false
        
        containerForImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerForImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerForImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerForImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        textOfNote.topAnchor.constraint(equalTo: containerForImage.bottomAnchor, constant: 10).isActive = true
        textOfNote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        textOfNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textOfNote.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        textOfNote.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
