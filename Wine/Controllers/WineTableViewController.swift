//
//  WineTableViewController.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 30/01/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class WineTableViewController: UITableViewController {
    
    var viewModel: WineTableViewModel = WineTableViewModel()
    
    var region: Region?
    
    init(style: UITableViewStyle, _ region: Region) {
        super.init(style: style)
        self.region = region
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        tableView.dataSource = viewModel
        
        guard let name = region?.name else { return }
        title = "\(name) Wines"
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://wines-api.herokuapp.com/api/wines?region=\(name)")!) { (data, response, error) in
            do {
                let wines = try JSONDecoder().decode([Wine].self, from: data!)
                wines.forEach({ [weak self] wine in
                    if let strongSelf = self {
                        strongSelf.viewModel.tableView(strongSelf.tableView, insert: wine)
                    }
                })
            } catch let error as NSError {
                print(error.description)
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wine = viewModel.model.wineArray[indexPath.row]
        navigationController?.pushViewController(WineDetailViewController(wine, nibName: nil, bundle: nil), animated: true)
    }
    
}
