//
//  TrelloBoardDataManager.swift
//  SecondSprintApp
//
//  Created by Svetlana Timofeeva on 15/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case id
    case name
    case closed
    case idBoard
    case desc
    case idList
}

class TrelloBoard: Codable {
    let id: String
    let name: String
    let closed: Bool
}

class TrelloListItem: Codable {
    let id: String
    let name: String
    let closed: Bool
    let idBoard: String
}

class TrelloCard: Codable {
    let id: String
    let name: String
    let desc: String
    let idBoard: String
    let closed: Bool
    let idList: String
    
    init(name: String, desc: String, idList: String) {
        self.name = name
        self.desc = desc
        self.idList = idList
        idBoard = ""
        closed = false
        id = ""
    }
}

class TrelloBoardDataManager {
    private let apiKey = "41e5cca66b481f8556a7fc1757850455"
    private let token = "30b74ad9248acfd7de99ea4fcdf3a57ae597ce5c2eda9fd78c9b58aa42ca34fa"
    private let board_id = "5dc3ff3db16c1b044c288835"
    private let url = "https://api.trello.com/1/boards/"
    
    var board: TrelloBoard? {
        didSet{
            print("called after setting the new value")
        }
    }
    var list: [TrelloListItem]? {
        didSet {
            print("called after setting the new value")
        }
    }
    var cards: [TrelloCard]? {
        didSet {
            print("called after setting the new value")
        }
    }
    let session: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    
    init() {
        self.initBoard()
        self.initList()
        self.initCards()
        //sleep(2)
    }
    
    
    func initBoard() {
        let boardURL = URL(string: self.url + self.board_id + "?key=" + self.apiKey + "&token=" + self.token)!
        let request = URLRequest(url: boardURL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 60)
        let task = self.session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let board = try JSONDecoder().decode(TrelloBoard.self, from: data!)
                
                self.board = board
                
            } catch {
                print(error)
            }
        })
        
        task.resume()

    }
    
    func initList() {
        let listRequest = URLRequest(url: URL(string: self.url + self.board_id + "/lists?key=" + self.apiKey + "&token=" + self.token)!,
                                     cachePolicy: .useProtocolCachePolicy,
                                     timeoutInterval: 60)
        let task = self.session.dataTask(with: listRequest, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let list = try JSONDecoder().decode([TrelloListItem].self, from: data!)
                self.list = list
                //print(list)
            } catch {
                print(error)
            }
        })
        task.resume()

    }
    
    
    func initCards() {
        let cardRequest = URLRequest(url: URL(string: self.url + self.board_id + "/cards?key=" + self.apiKey + "&token=" + self.token)!,
                                     cachePolicy: .useProtocolCachePolicy,
                                     timeoutInterval: 60)
        let task = self.session.dataTask(with: cardRequest, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let cards = try JSONDecoder().decode([TrelloCard].self, from: data!)
                self.cards = cards
   
                //print(cards)
            } catch {
                print(error)
            }
        })
        task.resume()
        //dispatchGroup.leave()
    }
    
    

    func printBoard() {
        print("\n---------------- BOARD -----------------\n")
        print(self.board ?? "")
        print("---------------- END BOARD -----------------\n\n")
        
        print("---------------- LIST -----------------\n")
        for item in (self.list ?? []) {
            print(item)
        }
        print("---------------- END LIST -----------------\n")
        
        print("---------------- CARDS -----------------\n")
        for card in self.cards ?? [] {
            print(card)
        }
        print("---------------- END CARDS -----------------\n")
        
    }
    
    func addCard(_ card: TrelloCard) {
        guard card.idList != "" else { return }
        
        guard let uploadData = try? JSONEncoder().encode(card) else { return }
        
        let urlString = "https://api.trello.com/1/cards?idList=\(card.idList)&keepFromSource=all&key=\(apiKey)&token=\(token)&name=\(card.name)&desc=\(card.desc)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let myUrl = URL(string: urlString)!
        print(myUrl.absoluteString)
        
        var request = URLRequest(url: myUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
        task.resume()
        
        return
    }
}

extension TrelloBoardDataManager: CustomStringConvertible {
    public var description: String {
        var result = ""
        result += "\(self.board)"
        for item in self.list! {
            result += "\(item)"
        }
        for card in self.cards! {
            result += "\(card)"
        }
        return result
    }
}

extension TrelloCard: CustomStringConvertible {
    public var description: String {
        return "id: \(id)\nname: \(name)\ndesc: \(desc)\n"
    }
}

extension TrelloListItem: CustomStringConvertible {
    public var description: String {
        return "id: \(id)\nname: \(name)\n"
    }
}

extension TrelloBoard: CustomStringConvertible {
    public var description: String {
        return "id: \(id)\nname: \(name)\n"
    }
}


final class TrelloBoardDataManagerSingleton {
    static let shared = TrelloBoardDataManager()
    private init() {}
}
