//
//  Card.swift
//  Concentration
//
//  Created by Minsoo Kim on 8/13/19.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import Foundation


struct Card: Hashable{
    //difference between struct and class
    //struct has no inheritance
    //struct has value types and classes are reference types
    //value types: Arrays, Int, Dict
    //reference types: you're just passing the pointers around to it when you copy it
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    //we are in the model of MVC not the UI
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int{
        //static means it is tied to the TYPE card not the actual object card. see below that we use Card. not self.
        identifierFactory += 1
        return identifierFactory
    }
    
    init (){ //same internal and external name
        self.identifier = Card.getUniqueIdentifier()
    }
}
