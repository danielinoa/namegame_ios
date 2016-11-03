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
    
    let people: [Person]
    
    // MARK: - Lifecycle
    
    init(people: [Person]) {
        self.people = people
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hintBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(hint))
        navigationItem.rightBarButtonItem = hintBarButtonItem
        configureGame(with: people)
    }
    
    // MARK: -
    
    private func configureGame(with people: [Person]) {
        
        // Reset buttons
        imageButtons.forEach({
            $0.removeTint()
            $0.hideName()
            $0.isUserInteractionEnabled = true
            $0.titleLabel?.text = ""
            $0.alpha = 1
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
        questionLabel.text = "Who is \(guesser.chosenElement.name)?"
    }
    
    // MARK: - Actions
    
    @objc private func hint() {
        guard guesser != nil else { return }
        let hint = guesser!.randomHint()
        if let hintIndex = guesser!.sample.index(where: { hint == $0 }) {
            let button = imageButtons[hintIndex]
            button.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.5) {
                button.alpha = 0
            }
        }
    }
    
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
