//
//  Card.swift
//  Concentration
//
//  Created by IvanChiang on 2018/4/3.
//  Copyright © 2018 IvanChiang. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {return identifier}
    
    static func==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func pairUniqueIdentifier() -> Int{
        identifierFactory += 1
        //print("card id:\(identifierFactory)")
        return identifierFactory
    }
    init () {
        self.identifier = Card.pairUniqueIdentifier()
    }
}
