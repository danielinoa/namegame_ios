//
//  GameModesViewController.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/2/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class GameModesViewController: UITableViewController {

    private let modes = GameMode.all
    private var people: [Person] = []
    
    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadData()
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        loadData()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Game Modes"
    }
    
    // MARK: -
    
    private func loadData() {
        Person.fetchPeople { people in
            DispatchQueue.main.async {
                self.people = people
            }
        }
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let mode = modes[indexPath.row]
        cell.textLabel?.text = mode.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if modes[indexPath.row] == .normal {
            let nameGameViewController = NameGameViewController(people: people)
            show(nameGameViewController, sender: self)
        }
    }

}
