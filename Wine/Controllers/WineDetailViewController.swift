//
//  WineDetailViewController.swift
//  Wine
//
//  Created by JOFFRE Jean-baptiste on 07/02/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class WineDetailViewController: UITableViewController {
    
    var wine: Wine?
    var image: UIImage?
    
    init(_ wine: Wine, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.wine = wine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        guard let wineName = wine?.name else { return }
        title = wineName
        tableView.backgroundColor = .white;
        navigationController?.isNavigationBarHidden = true
        
        let containerView = getHeaderView()
        tableView.tableHeaderView = containerView
        
        containerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        // 4.
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView

        
        guard let id = wine?.id else { return }
        let task = URLSession.shared.dataTask(with: URL(string: "https://wines-api.herokuapp.com/api/wines/\(id)/image")!) { (data, response, error) in
            if let data = data, error == nil {
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data)
                    self.tableView.reloadData()
                    
                    let containerView = self.getHeaderView()
                    self.tableView.tableHeaderView = containerView
                    
                    containerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
                    containerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
                    containerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
                    
                    self.tableView.tableHeaderView?.layoutIfNeeded()
                }
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 300)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 300)
    }
    
    func getHeaderView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300))
        let uilbl = UILabel()
        let backButton = UIButton(type: .system)
        let imageView = UIImageView(image: image)
        
        uilbl.numberOfLines = 0
        uilbl.lineBreakMode = .byWordWrapping
        if let name = wine?.name {
            uilbl.text = name
        }
        uilbl.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        view.addSubview(uilbl)
        view.addSubview(backButton)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        uilbl.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        uilbl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uilbl.leftAnchor.constraint(equalTo: backButton.rightAnchor).isActive = true
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "cellDetail")
    }
    
}
