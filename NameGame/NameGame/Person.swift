//
//  Person.swift
//  NameGame
//
//  Created by Daniel Inoa on 11/2/16.
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import Foundation

struct Person: Equatable, CustomStringConvertible {
    
    let name: String
    let imageUrl: String
    
    init?(dictionary: [String: String]) {
        guard let name = dictionary["name"], !name.isEmpty else { return nil }
        guard let imageUrl = dictionary["url"], !imageUrl.isEmpty else { return nil }
        self.name = name
        self.imageUrl = imageUrl
    }
    
    static func fetchPeople(completion: ((_ people: [Person]) -> Void)? = nil) {
        let url = URL(string: "http://api.namegame.willowtreemobile.com")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let peopleArray = json as? [[String: String]] {
                let people = peopleArray.flatMap({ Person(dictionary: $0) })
                completion?(people)
            }
        }
        task.resume()
    }
    
    var description: String {
        return "name: \(name), imageUrl: \(imageUrl)"
    }
    
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
}
