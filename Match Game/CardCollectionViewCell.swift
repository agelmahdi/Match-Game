//
//  CardCollectionViewCell.swift
//  Match Game
//
//  Created by Ahmed El-Mahdi on 7/31/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontCard: UIImageView!
    
    @IBOutlet weak var backCard: UIImageView!
    
    var card: Card?
    
    func setCard(_ card: Card) {
        
        self.card = card
        
        if card.isMatched == true {
            
            frontCard.alpha = 0
            backCard.alpha = 0
            
            return
        }
        else {
            frontCard.alpha = 1
            backCard.alpha = 1
        }
        
        
        frontCard.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true{
            flip(0.0)
        }
        else{
            flipBack(0.0)
        }
        
    }
    func flip(_ duration: Double) {
        
        UIView.transition(from: backCard, to: frontCard, duration: duration, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    func flipBack(_ duration: Double){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontCard, to: self.backCard, duration: duration, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)        }
        
    }
    
    
    func remove(){
        
        UIView.animate(withDuration: 0.4, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontCard.alpha = 0
        }, completion: nil)
        backCard.alpha = 0
    }
}
