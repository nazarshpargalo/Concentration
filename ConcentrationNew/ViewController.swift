//
//  ViewController.swift
//  ConcentrationNew
//
//  Created by Назарій on 14.04.2020.
// /Users/nazari_shpargalo/Dev/ios/ConcentrationNew/ConcentrationNew/Base.lproj/Main.storyboard Copyright © 2020 Назарій Шпаргало. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1)  / 2
    }
    
    
    private(set)  var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber )
            updateViewFromModel()
        } else {
            print("chosen button is not in card buttons")
        }
    }
    
    @IBAction private func newGame(_ sender: Any) {
        flipCount = 0
        emojiChoices = ["😇", "😎", "🤬", "🥶", "👹", "👽", "💩", "🎃"]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)  / 2)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index] 
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["😇", "😎", "🤬", "🥶", "👹", "👽", "💩", "🎃"]
    
    private  var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random )
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

