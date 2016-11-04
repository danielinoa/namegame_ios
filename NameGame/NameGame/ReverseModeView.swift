//
//  ReverseModeView.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/3/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class ReverseModeView: NameGameView {

    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var chosenPersonImageView: UIImageView!
    @IBOutlet private var faceButtons: [FaceButton]!
    
    override var buttons: [FaceButton] {
        return faceButtons
    }
    
    override func configure(people: [Person], chosenPerson: Person) {
        assert(people.count == faceButtons.count)
        faceButtons.forEach {
            $0.removeTint()
            $0.isUserInteractionEnabled = true
            $0.alpha = 1
        }
        faceButtons.enumerated().forEach({
            let person = people[$0.offset]
            $0.element.setTitle(person.name, for: .normal)
        })
        configureImage(person: chosenPerson)
    }
    
    private func configureImage(person: Person) {
        guard let imageURL = URL(string: person.imageUrl) else {
            preconditionFailure("Invalid image link")
        }
        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            DispatchQueue.main.async { () -> Void in
                self.chosenPersonImageView.image = image
            }
        }).resume()
    }

}
