//
//  Concentration.swift
//  Concentration
//
//  Created by IvanChiang on 2018/4/3.
//  Copyright © 2018 IvanChiang. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOnlyOneFaceUp: Int? { //Computed properties without default value
        get { // One and only face up card be found
            return cards.indices.filter {cards[$0].isFaceUp}.OneAndOnly
//            var foundOne: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundOne == nil { //Found the 1st one face up
//                        foundOne = index
//                    } else { //There're two cards face up
//                        return nil
//                    }
//                }
//            }
//            return foundOne
        }
        set {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = (flipDownIndex == newValue)
            }
        }
    }
    mutating func chooseCard (at Index: Int) {
        assert(cards.indices.contains(Index),"Concentration.chooseCard(at: \(Index)), choosen Index is not there")
        if !cards[Index].isMatched {
            if let matchIndex = indexOfOnlyOneFaceUp, matchIndex != Index {//2nd cards
                if cards[matchIndex] == cards[Index] {
                    cards[matchIndex].isMatched = true
                    cards[Index].isMatched = true
                }
                cards[Index].isFaceUp = true
            } else {
                indexOfOnlyOneFaceUp = Index //1st card be clicked
            }
            
        }
    }
    mutating func shufflingCard (numberOfPairsOfCards: Int) {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
        //TODO: Shuffle the cards
        for _ in 1...(numberOfPairsOfCards*2)
        {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.append(cards.remove(at: randomIndex))
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init \(numberOfPairsOfCards), you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards
        {
            let loadingCard = Card()
            cards += [loadingCard, loadingCard]
            print("cards:\(cards)")
        }
        //TODO: Shuffle the cards
        shufflingCard(numberOfPairsOfCards: numberOfPairsOfCards)
    }
}

extension Collection {
    var OneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
