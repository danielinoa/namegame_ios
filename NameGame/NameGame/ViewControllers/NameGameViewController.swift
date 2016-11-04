//
//  ViewController.swift
//  NameGame
//
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class NameGameViewController: UIViewController {
    
    private var guesser: Guesser<Person>?
    
    let people: [Person]
    
    private var nameGameView: NameGameView {
        return view as! NameGameView
    }
    
    // MARK: - Lifecycle
    
    init(people: [Person]) {
        self.people = people
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("\(#function) not implemented.") }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { fatalError("\(#function) not implemented.") }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        let nameGameView = UINib(nibName: "NormalModeView", bundle: nil).instantiate(withOwner: self, options: nil).first as! NameGameView
        nameGameView.buttons.forEach { $0.addTarget(self, action: #selector(tapped(button:)), for: .touchUpInside) }
        view = nameGameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hintBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(hint))
        navigationItem.rightBarButtonItem = hintBarButtonItem
        configureGame(with: people)
    }
    
    // MARK: -
    
    private func configureGame(with people: [Person]) {
        // Produce random sample of people
        let samplePeople = people.random(sampleSize: nameGameView.buttons.count)
        
        // Configure `Guesser` with sample set
        let guesser = Guesser(sample: samplePeople)
        self.guesser = guesser
        
        // configure view
        nameGameView.configure(people: samplePeople, question: "Who is \(guesser.chosenElement.name)?")
    }
    
    // MARK: - Actions
    
    @objc private func hint() {
        guard guesser != nil else { return }
        let hint = guesser!.randomHint()
        if let hintIndex = guesser!.sample.index(where: { hint == $0 }) {
            let button = nameGameView.buttons[hintIndex]
            button.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.5) {
                button.alpha = 0
            }
        }
    }
    
    @objc private func tapped(button: FaceButton) {
        guard let tappedButtonIndex = nameGameView.buttons.index(of: button), let guesser = guesser else {
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
