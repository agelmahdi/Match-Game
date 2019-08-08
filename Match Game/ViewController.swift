//
//  ViewController.swift
//  Match Game
//
//  Created by Ahmed El-Mahdi on 7/31/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var cardUICollectionView: UICollectionView!
    
    var model = CardModel()
    
    var cardArray = [Card]()
    
    var firstFlippedCard: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardUICollectionView.delegate = self
        cardUICollectionView.dataSource = self
        cardArray = model.getCards()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
            as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            card.isFlipped = true
            
            cell.flip(0.3)
            
            if firstFlippedCard == nil {
                firstFlippedCard = indexPath
            }
            else{
                
                // TODO: perform the match logic
                checkForMatch(collectionView , indexPath);
            }
            
        }
       
        
    }
    
    //MARK: - Game Logic Methods

    func checkForMatch(_ collectionView: UICollectionView,_ secondFlippedCard: IndexPath) {
                
                let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CardCollectionViewCell
                
                let cardTwoCell = collectionView.cellForItem(at: secondFlippedCard) as? CardCollectionViewCell
                
                let cardOne = cardArray[firstFlippedCard!.row]
                
                let cardTwo = cardArray[secondFlippedCard.row]
                
                
                if cardOne.imageName == cardTwo.imageName {
                    
                    cardOne.isMatched = true
                    cardTwo.isMatched=true
                    
                    cardOneCell?.remove()
                    cardTwoCell?.remove()
                    
                    //collectionView.deleteItems(at: [firstFlippedCard!,secondFlippedCard ])

                    
                }
                else {
                    cardOne.isFlipped = false
                    cardTwo.isFlipped = false
                    
                    cardOneCell?.flipBack(0.3)
                    cardTwoCell?.flipBack(0.3)
                }
                
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCard!])
        }
                firstFlippedCard = nil
                
                
            }
    
}

