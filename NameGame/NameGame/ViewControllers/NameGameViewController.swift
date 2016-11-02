//
//  ViewController.swift
//  NameGame
//
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class NameGameViewController: UIViewController {

    @IBOutlet private weak var outerStackView: UIStackView!
    @IBOutlet private weak var innerStackView1: UIStackView!
    @IBOutlet private weak var innerStackView2: UIStackView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private var imageButtons: [FaceButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        let orientation: UIDeviceOrientation = view.frame.size.height > view.frame.size.width ? .portrait : .landscapeLeft
        configureSubviews(orientation)
    }

    // Load JSON data from API
    private func loadData() {
        // TODO:
    }

    @IBAction func faceTapped(_ button: FaceButton) {
        // TODO:
    }

    private func configureSubviews(_ orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            outerStackView.axis = .vertical
            innerStackView1.axis = .horizontal
            innerStackView2.axis = .horizontal
        } else {
            outerStackView.axis = .horizontal
            innerStackView1.axis = .vertical
            innerStackView2.axis = .vertical
        }
    }
    
}
