//
//  NotesScreenViewController.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 09/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

var noteNum: Int = 0

class NotesScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Notes"
        
        // Do any additional setup after loading the view.
//        let title = UIBarButtonItem(title: "Notes: \(noteNum)", style: .plain, target: self, action: #selector(barTitle))
         // you will probably need to move it into viewWillAppear
        
        let newNoteButton = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(onNewNoteButtonTapped))
        self.tabBarController?.navigationItem.setRightBarButton(newNoteButton, animated: true)
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
        self.tabBarController?.navigationItem.title = "Notes (\(noteNum))"
        navigationController?.isNavigationBarHidden = false
    }
}
