//
//  WineTableViewController.swift
//  WineSerli
//
//  Created by JOFFRE Jean-baptiste on 15/03/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class WineTableViewController: UITableViewController {
    
    var region: Region?
    var wines: [Wine] = []
    
    init(style: UITableViewStyle, _ region: Region) {
        super.init(style: style)
        self.region = region
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "Wines"
        let name = region?.name
        URLSession.shared.dataTask(with: URL(string: "https://wines-api.herokuapp.com/api/wines?region=\(name ?? "bourgogne")")!) { data, response, error in
            let wines = try? JSONDecoder().decode([Wine].self, from: data!)
            wines?.forEach({ [weak self] wine in
                if let strongSelf = self {
                    strongSelf.wines.append(wine)
                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                    }
                }
            })
            }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") ?? UITableViewCell(style: .default, reuseIdentifier: "CELL")
        let wine = wines[indexPath.row]
        cell.textLabel?.text = wine.name
        cell.detailTextLabel?.text = wine.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
