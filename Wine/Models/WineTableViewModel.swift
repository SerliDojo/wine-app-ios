//
//  WineTableViewModel.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 30/01/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

public struct Wine: Codable {
    let id: String
    let name: String
    let type: String
    let appellation: Appellation
    let grapes: [String]
}

public struct Appellation: Codable {
    let name: String
    let region: String
}

extension Wine: CustomStringConvertible {
    public var description: String {
        return "\(name) : \(type) : \(grapes)"
    }
}

public class WineTableViewModel: NSObject, UITableViewDataSource {

    var model: WineModel = WineModel()
    
    var count: Int {
        get {
            return model.wineArray.count
        }
    }
    
    func addWine(_ wine: Wine) {
        model = model.addWine(wine)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") ?? UITableViewCell(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = model.wineArray[indexPath.row].name
        return cell
    }
    
    public func tableView(_ tableView: UITableView,
                          insert wine: Wine) {
        DispatchQueue.main.async {
            self.model = self.model.addWine(wine)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                 with: .fade)
        }
    }
    
}

class WineModel {
    let wineArray: [Wine]
    
    init() {
        wineArray = []
    }
    
    private init(_ wineArray: [Wine]) {
        self.wineArray = wineArray
    }
    
    public func addWine(_ wine: Wine) -> WineModel {
        var privateWineArray = wineArray
        privateWineArray.insert(wine, at: 0)
        return WineModel(privateWineArray)
    }
}
