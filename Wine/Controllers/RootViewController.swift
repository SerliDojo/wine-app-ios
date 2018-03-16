//
//  RootViewController.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 30/01/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        title = "Region List"
        setViewControllers([RegionTableViewController(style: .plain)], animated: true)
    }
    
}
