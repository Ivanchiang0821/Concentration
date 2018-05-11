//
//  ViewController.swift
//  Concentration
//
//  Created by IvanChiang on 2018/3/31.
//  Copyright © 2018 IvanChiang. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    //lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1 ) / 2 )
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    private var numberOfPairsOfCards: Int { //Computed property, it compute
            return (visibleCardButtons.count + 1 ) / 2
    }
    private func updateFlipCountLable() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributeString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? " Flips\n\(flipCount)" : " Flips: \(flipCount)",
            attributes: attributes
        )
        flipCountLabel.attributedText = attributeString
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLable()
    }
    private(set) var flipCount = 0 {//Property Observer, Observering rather than computing
        didSet {
            updateFlipCountLable()
//            flipCountLabel.text = "flips: \(flipCount)"
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupScence()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = visibleCardButtons.index(of: sender){
            print("cardNumber:\(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("choosen card isn't there")
        }
    }
    @IBAction private func newGame(_ sender: UIButton) {
        resumeViewFromModel()
    }
    
    private func resumeViewFromModel() {
        flipCount = 0
        for index in visibleCardButtons.indices {
            let button = visibleCardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
//        setupScence()
//        emojiDic.removeAll()
        game.shufflingCard(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    private func updateViewFromModel() {
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                //print("cardButtons index:\(index)")
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emojiRandomPick(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
    }
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emojiDic = [:]
            updateViewFromModel()
        }
    }
    private var emojiChoices = "👻🎃🧟‍♀️🧛‍♂️🧜‍♀️🧞‍♀️🧚‍♂️🧜‍♂️"
//    private var halloween = [""], emojiFaces = [""], handGesture = [""], faces = [""], dress = [""], animals = [""], allScene = [[""]], randomScene = [""]
//    private func setupScence() {
//        halloween = ["👻", "🎃", "🧟‍♀️", "🧛‍♂️", "🧜‍♀️", "🧞‍♀️", "🧚‍♂️", "🧜‍♂️"]
//        emojiFaces = ["😃", "😗", "😎", "😡", "😱", "🤪", "😇", "😷"]
//        handGesture = ["🤲", "👏", "👍", "✊", "🤟", "👌", "✌️", "🖕"]
//        faces = ["👩", "👱‍♀️", "💂‍♀️", "🧕", "👮‍♀️", "👩‍🌾", "👩‍🍳", "🤴"]
//        dress = ["🧥", "👚", "👖", "👔", "👗", "👘", "👙", "👕"]
//        animals = ["🦆", "🦁", "🐰", "🐷", "🐸", "🐼", "🦄", "🐒"]
//        allScene = [halloween, emojiFaces, handGesture, faces, dress, animals]
//        randomScene = getRandomScene()
//    }
//    private func getRandomScene() -> [String] {
//        let index = allScene.count.arc4random
//        return allScene[index]
//    }
    private var emojiDic = [Card: String]()
    private func emojiRandomPick(for card: Card) -> String {
        if emojiDic[card] == nil, emojiChoices.count > 0 {
//                emojiDic[card] = randomScene.remove(at: randomScene.count.arc4random)
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojiDic[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emojiDic[card] ?? "?"
        //if emoji[card.identifier] != nil {
        //       return emoji[card.identifier]!
        //}else{ return "?"
        //}
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
