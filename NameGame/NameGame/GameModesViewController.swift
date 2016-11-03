//
//  GameModesViewController.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/2/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

class GameModesViewController: UITableViewController {

    let modes = GameMode.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let mode = modes[indexPath.row]
        cell.textLabel?.text = mode.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if modes[indexPath.row] == .normal {
            let nameGameViewController = NameGameViewController()
            show(nameGameViewController, sender: self)
        }
    }

}
