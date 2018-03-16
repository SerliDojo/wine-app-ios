//
//  Wine.swift
//  WineSerli
//
//  Created by JOFFRE Jean-baptiste on 15/03/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation

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
