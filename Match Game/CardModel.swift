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
        
        var generatedNumbersArray = [Int]()
        
        while generatedNumbersArray.count < 8 {
            
            let randomNum = arc4random_uniform(13) + 1
            
            if !generatedNumbersArray.contains(Int(randomNum)){
                
                let cardOne = Card()
                
                cardOne.imageName = "card\(randomNum)"
                
                generatedNumbersArray.append(Int(randomNum))
                
                gereratedCardsArray.append(cardOne)
                
                let cardTwo = Card()
                
                cardTwo.imageName = "card\(randomNum)"
                
                gereratedCardsArray.append( cardTwo)
                
                print(randomNum)
            }
            
            for i in 0...gereratedCardsArray.count - 1 {
                
                let randomNumber = Int(arc4random_uniform(UInt32(gereratedCardsArray.count)))
                
                let temporaryStorage = gereratedCardsArray[i]
                
                gereratedCardsArray[i] = gereratedCardsArray[randomNumber]
                
                gereratedCardsArray[randomNumber] = temporaryStorage;
                
            }
            
            
        }
        return gereratedCardsArray
    }
}
