//
//  ConcentrationChooseViewController.swift
//  Concentration
//
//  Created by IvanChiang on 2018/4/21.
//  Copyright © 2018 IvanChiang. All rights reserved.
//

import UIKit

class ConcentrationChooseViewController: UIViewController {

    let themes = [
        "Halloween": "👻🎃🧟‍♀️🧛‍♂️🧜‍♀️🧞‍♀️🧚‍♂️🧜‍♂️",
        "Faces": "👩👱‍♀️💂‍♀️🧕👮‍♀️👩‍🌾👩‍🍳🤴",
        "Dress": "🧥👚👖👔👗👘👙👕",
        "EmojiFaces": "😃😗😎😡😱🤪😇😷",
        "HandGesture": "🤲👏👍✊🤟👌✌️🖕",
        "Animals": "🦆🦁🐰🐷🐸🐼🦄🐒"
    ]
//    private func getRandomScene() -> String {
//        return themes.startIndex
//    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    if let theme = themes[themeName] {
                        if let cvc = segue.destination as? ConcentrationViewController {
                            cvc.theme = theme
                        }
                    }
                }
            }
        }
    }
}
