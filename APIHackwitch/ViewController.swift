//
//  ViewController.swift
//  APIHackwitch
//
//  Created by ALEJANDRO MORENO on 10/1/18.
//  Copyright © 2018 ALEJANDRO MORENO. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController { 
    
    var sources = [[String: String]]()
    var apiKey = "679376b10aad42019ff49513ad555602"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Sources"
        let query = "https://newsapi.org/v1/sourceslanguage=en&country=us&apiKey=\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["status"] == "ok" {
                    parse(json: json)
                    return
                }
            }
        }
        loadError()
    }
    func parse(json: JSON) {
        for result in json["sources"].arrayValue {
            let id = result["id"].stringValue
            let name = result["name"].stringValue
            let description = result["description"].stringValue
            let source = ["id": id, "name" : name, "descrption" : description]
            sources.append(source)
            tableView.reloadData()
        }
    }
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                message: "There was a problem loading the newsfeed",
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}
