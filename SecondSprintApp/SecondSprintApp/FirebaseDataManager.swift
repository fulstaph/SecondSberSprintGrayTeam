//
//  FirebaseDataManager.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 18/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation
import UIKit

struct Note: Codable {
    let id: String
    let text: String
    let imgUrl: String
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case imgUrl
    }
}


class FirebaseDataManager {
    public var notes: [String : Note] = [:]
    
    init() {
        let dataURL = URL(string: "https://grayteamdatabase.firebaseio.com/Notes.json?")!
        let request = URLRequest(url: dataURL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 60)
        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {
                                                (data: Data?, response: URLResponse?, error: Error?) in
                                                do {
                                                    self.notes = try JSONDecoder().decode([String : Note].self, from: data!)
                                                } catch {
                                                    print(error)
                                                }
        })
        task.resume()
        
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, with text: String) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                    NoteSingleton.shared.notes.addNote(withText: text, withImage: UIImage(data: data)!)
            }
        }
    }
}
