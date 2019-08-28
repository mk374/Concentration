//
//  Concentration.swift
//  Concentration
//
//  Created by Minsoo Kim on 8/13/19.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }
//                    else{ //if foundIndex has already been assigned
//                        //so foundIndex is nil when there's two or zero
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
//            let faceUpCardIndices = cards.indices.filter({cards[$0].isFaceUp})
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first: nil
//            //if faceupcardindices.count is = 1 then return faceupcardindices.first, else return nil
            
            return cards.indices.filter({
                cards[$0].isFaceUp
            }).oneAndOnly //look at the extension below
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
                
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else{
//                // either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Number of cards is less than 0")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
//            let matchingCard = card //it makes it a copy not a reference copyy
            //when you are appending the card, you are copyying the card.
//            cards.append(card)
//            cards.append(card)
            // or
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    
        cards.shuffle()
        
    }
}


extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
