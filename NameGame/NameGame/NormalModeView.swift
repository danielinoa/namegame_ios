//
//  NormalModeView.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/3/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

/**
 Displays a collection of people's images to choose from, and the chosen person's name.
 */
final class NormalModeView: NameGameView {
    
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private var faceButtons: [FaceButton]!

    override var buttons: [FaceButton] {
        return faceButtons
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttons.forEach { $0.addTarget(self, action: #selector(tapped(button:)), for: .touchUpInside) }
    }
    
    override func configure(people: [Person], chosenPerson: Person) {
        assert(people.count == faceButtons.count)
        faceButtons.enumerated().forEach {
            $0.element.removeTint()
            $0.element.hideName()
            $0.element.isUserInteractionEnabled = true
            $0.element.alpha = 1
            
            let person = people[$0.offset]
            $0.element.setTitle(person.name, for: .normal)
            $0.element.loadImageFromURL(url: person.imageUrl)
        }
        questionLabel.text = "Who is \(chosenPerson.name)"
    }
 
    @objc private func tapped(button: FaceButton) {
        button.animateDisplayName()
    }
    
    // MARK: - NibLoadable
    
    override class var nibName: String {
        return "NormalModeView"
    }
    
}
