//
//  RegionTableViewController.swift
//  WineSerli
//
//  Created by JOFFRE Jean-baptiste on 15/03/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class RegionTableViewController: UITableViewController {
    
    var regions: [Region] = []
    
    override func viewDidLoad() {
        self.title = "Regions"
        URLSession.shared.dataTask(with: URL(string: "https://wines-api.herokuapp.com/api/regions")!) { data, response, error in
            let regions = try? JSONDecoder().decode([String].self, from: data!)
            regions?.forEach({ [weak self] region in
                if let strongSelf = self {
                    strongSelf.regions.append(Region(name: region))
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
        return regions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") ?? UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = regions[indexPath.row].name
        cell.detailTextLabel?.text = "oualala"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = WineTableViewController(style: .plain, regions[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
