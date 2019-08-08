//
//  CardModel.swift
//  Match Game
//
//  Created by Ahmed El-Mahdi on 7/31/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        var gereratedCardsArray = [Card]()
        

        
        for _ in 1...8{
            
            let randomNum = arc4random_uniform(13) + 1
            
            let cardOne = Card()
            
            cardOne.imageName = "card\(randomNum)"
            
            gereratedCardsArray.append(cardOne)
            
            let cardTwo = Card()
            
            cardTwo.imageName = "card\(randomNum)"
            
            gereratedCardsArray.append( cardTwo)
            
            
            print(randomNum)
        }
        return gereratedCardsArray
    }
}
