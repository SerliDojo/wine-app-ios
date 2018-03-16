//
//  RegionTableViewController.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 06/02/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

import ModalStatus

class RegionTableViewController: UITableViewController {
    
    var viewModel: RegionTableViewModel = RegionTableViewModel()
    
    override func viewDidLoad() {
        title = "Regions"
        tableView.dataSource = viewModel
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://wines-api.herokuapp.com/api/regions")!) { (data, response, error) in
            let regions = try? JSONDecoder().decode([String].self, from: data!)
            regions?.forEach({ [weak self] region in
                if let strongSelf = self {
                    strongSelf.viewModel.tableView(strongSelf.tableView, insert: Region(name: region))
                }
            })
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = viewModel.model.regionArray[indexPath.row]
        self.presentModal(region)
        Timer.scheduledTimer(withTimeInterval: TimeInterval(3.0), repeats: false) { (timer) in
            let wineController = WineTableViewController(style: .plain, self.viewModel.model.regionArray[indexPath.row])
            self.navigationController?.pushViewController(wineController, animated: true)
        }
    }
    
    func presentModal(_ region: Region) {
        let modalView = ModalStatusView(frame: self.view.bounds)
            .set(headline: region.name)
            .set(subHeadline: "une superbe region")
            .set(modalImage: #imageLiteral(resourceName: "default-image"))
        view.addSubview(modalView)
    }
}
