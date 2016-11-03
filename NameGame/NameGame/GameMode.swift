//
//  GameMode.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/2/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import Foundation

enum GameMode {
    
    case normal
    case reverse
    case matt
    
    var title: String {
        switch self {
            case .normal: return "Normal"
            case .reverse: return "Reverse"
            case .matt: return "Mat(t)"
        }
    }
    
    static var all: [GameMode] {
        return [.normal, .reverse, .matt]
    }
    
}
