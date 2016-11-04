//
//  NibLoadable.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/4/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
    static func loadFromNib() -> UIView
}

extension NibLoadable {
    
    static func loadFromNib() -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }
        fatalError("Unable to load \(nibName) nib")
    }
    
}
