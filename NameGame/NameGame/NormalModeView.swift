//
//  NormalModeView.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/3/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

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
        faceButtons.forEach {
            $0.removeTint()
            $0.hideName()
            $0.isUserInteractionEnabled = true
            $0.alpha = 1
        }
        faceButtons.enumerated().forEach({
            let person = people[$0.offset]
            $0.element.setTitle(person.name, for: .normal)
            $0.element.loadImageFromURL(url: person.imageUrl)
        })
        questionLabel.text = "Who is \(chosenPerson.name)"
    }
 
    @objc private func tapped(button: FaceButton) {
        button.animateDisplayName()
    }
    
}