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
    
    private var guesser: Guesser<Person>?
    
    private var people: [Person] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Data
    
    private func loadData() {
        Person.fetchPeople { people in
            DispatchQueue.main.async {
                self.people = people
                self.configureGame(with: people)
            }
        }
    }
    
    // MARK: -
    
    private func configureGame(with people: [Person]) {
        
        // Reset buttons
        imageButtons.forEach({
            $0.removeTint()
            $0.hideName()
            $0.isUserInteractionEnabled = true
            $0.titleLabel?.text = ""
        })
        
        // Produce random sample of people
        let samplePeople = people.random(sampleSize: imageButtons.count)
        
        // Configure image buttons with corresponding Person
        imageButtons.enumerated().forEach({
            let person = samplePeople[$0.offset]
            $0.element.configure(with: person)
        })
        
        // Configure `Guesser` with sample set
        let guesser = Guesser(sample: samplePeople)
        self.guesser = guesser
        
        // Configure question label with the Person to guess
        questionLabel.text = "Who is \(guesser.chosenElement.name)"
    }
    
    // MARK: - Actions
    
    @IBAction func faceTapped(_ button: FaceButton) {
        guard let tappedButtonIndex = imageButtons.index(of: button), let guesser = guesser else {
            fatalError()
        }
        button.animateDisplayName()
        button.isUserInteractionEnabled = false
        let tappedPerson = guesser.sample[tappedButtonIndex]
        if guesser.isChosenElement(element: tappedPerson) {
            button.setTint(color: .green)
            // reconfigure game after correct guess
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.configureGame(with: self.people)
            })
        } else {
            button.setTint(color: .red)
        }
    }
    
}
