//
//  ReverseModeView.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/3/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

/**
 Displays a collection of people's names to choose from, and the chosen person's image.
 */
final class ReverseModeView: NameGameView {

    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var chosenPersonImageView: UIImageView!
    @IBOutlet private var faceButtons: [FaceButton]!
    
    override var buttons: [FaceButton] {
        return faceButtons
    }
    
    override func configure(people: [Person], chosenPerson: Person) {
        assert(people.count == faceButtons.count)
        faceButtons.enumerated().forEach {
            $0.element.removeTint()
            $0.element.isUserInteractionEnabled = true
            $0.element.alpha = 1
            
            let person = people[$0.offset]
            $0.element.setTitle(person.name, for: .normal)
        }
        configureImage(person: chosenPerson)
    }
    
    private func configureImage(person: Person) {
        guard let imageURL = URL(string: person.imageUrl) else {
            preconditionFailure("Invalid image link")
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) -> Void in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.chosenPersonImageView.image = image
                }
            }
        }
        task.resume()
    }

}
