//
//  WineTableViewModel.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 30/01/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

public struct Region: Codable {
    let name: String
}

extension Region: CustomStringConvertible {
    public var description: String {
        return "\(name)"
    }
}

public class RegionTableViewModel: NSObject, UITableViewDataSource {
    
    var model: RegionModel = RegionModel()
    
    func addRegion(_ region: Region) {
        model = model.addRegion(region)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") ?? UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = model.regionArray[indexPath.row].name
        return cell
    }
    
    public func tableView(_ tableView: UITableView,
                          insert region: Region) {
        DispatchQueue.main.async {
            self.model = self.model.addRegion(region)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                 with: .fade)
        }
    }
    
}

class RegionModel {
    let regionArray: [Region]
    
    init() {
        regionArray = []
    }
    
    private init(_ regionArray: [Region]) {
        self.regionArray = regionArray
    }
    
    var count: Int {
        get {
            return regionArray.count
        }
    }
    
    public func addRegion(_ region: Region) -> RegionModel {
        var privateRegionArray = regionArray
        privateRegionArray.insert(region, at: 0)
        return RegionModel(privateRegionArray)
    }
}

