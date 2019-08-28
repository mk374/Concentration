//
//  ViewController.swift
//  Concentration
//
//  Created by Minsoo Kim on 8/13/19.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    //    var flipCount: Int = 0; could also be
    //swift is strongly-typed and strong-inferenced
    private lazy var game =  Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //internal - default. means usable by any object in my app or framework
    //private - callable only from within this object
    //private(set) - means is readable outside this object but not settable
    //fileprivate - accessible by any code in this source file
    
    
    //enum: another variety of data structure in addition to struct and class
    // it can only have discrete states (IT IS A VALUE TYPE) like a struct
    
    
    
    var numberOfPairsOfCards: Int{
//        get {
//            return (cardButtons.count + 1) / 2
//        }
        //or we can just return it if there is no set
        return (cardButtons.count + 1) / 2
    }
    
    
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes : [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.6222488757, blue: 0.1047864403, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // MARK: Handle Card Touch Behavior
    
    
    //[String] is optional to put in
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
//        let cardNumber = cardButtons.firstIndex(of: sender)!
        //! means to get the value of the Optional
        //An optional in Swift is a type that can hold either a value or no value.
        // or we can do
        if let cardNumber = cardButtons.firstIndex(of: sender){
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
//            print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            
            print("chosen card was not in cardbuttons")
        }
    }
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.6222488757, blue: 0.1047864403, alpha: 1)
            }
        }
    }
    
    
    private var emojiChoices: [String] = ["👻","🎃","🐱", "🦋", "🐍", "🐠"]
    
//    var emoji = Dictionary<Int, String> ()
// or
    private var emoji = [Card: String] ()
    private func emoji(for card: Card) -> String{
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        } else{
//            return "?"
//        }
        
        if emoji[card] == nil{
            if emojiChoices.count > 0 {
                
                emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
             return -Int(arc4random_uniform(UInt32(self)))
        } else{
            return 0
        }
    }
}

