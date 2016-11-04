//
//  NameGameView.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/3/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

/**
 This class acts as a abstract superclass to views that want to be integrated into NameGameViewController
 */
class NameGameView: UIView, NibLoadable {
    
    var buttons: [FaceButton] {
        fatalError("No implementation for \(#function)")
    }
    
    func configure(people: [Person], chosenPerson: Person) {
        fatalError("No implementation for \(#function)")
    }
    
    // MARK: - NibLoadable
    
    class var nibName: String {
        fatalError("No implementation for \(#function)")
    }
    
}
