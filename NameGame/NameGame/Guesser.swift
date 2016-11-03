//
//  Guesser.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/2/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import Foundation

/**
 This generic struct takes a non-empty array of elements and stores one of them at random.
 */
struct Guesser<T: Equatable> {
    
    private(set) var sample: [T]
    private(set) var chosenElement: T
    
    init(sample: [T]) {
        precondition(!sample.isEmpty)
        self.sample = sample
        chosenElement = sample.random()
    }
    
    func isChosenElement(element: T) -> Bool {
        return chosenElement == element
    }
    
    mutating func configure(sample: [T]) {
        precondition(!sample.isEmpty)
        self.sample = sample
        chosenElement = sample.random()
    }
    
}
