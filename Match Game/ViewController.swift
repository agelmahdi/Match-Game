//
//  ViewController.swift
//  Match Game
//
//  Created by Ahmed El-Mahdi on 7/31/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var cardUICollectionView: UICollectionView!
    
    var model = CardModel()
    
    var cardArray = [Card]()
    
    var firstFlippedCard: IndexPath?
    
    var timer: Timer?
    
    var milliseconds: Float = 30 * 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardUICollectionView.delegate = self
        cardUICollectionView.dataSource = self
        cardArray = model.getCards()
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        SoundsManager.playSound(.shuffle)
    }
    //MARK: - Timer Method
    
    @objc func timerElapsed()  {
        
        milliseconds -= 1
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLable.text = "Time Remaining \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLable.textColor = UIColor.red
            
            checkGameEnded()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        
        if milliseconds <= 0 {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            card.isFlipped = true
            
            SoundsManager.playSound(.flip)
            
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
            SoundsManager.playSound(.match)
            
            //collectionView.deleteItems(at: [firstFlippedCard!,secondFlippedCard ])
            
            checkGameEnded()
        }
        else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            SoundsManager.playSound(.nonmatch)
            cardOneCell?.flipBack(0.3)
            cardTwoCell?.flipBack(0.3)
        }
        
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCard!])
        }
        firstFlippedCard = nil
        
    }
    func checkGameEnded()  {
        
        var isWon = true
        
        var  title = ""
        var message = ""
        
        for card in cardArray {
            
            if !card.isMatched {
                isWon = false
                break
            }
            
        }
        if isWon {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulation!"
            message = "you ve won"
            showAlert(title,message)
        }
        else {
            
            if milliseconds > 0 {
                return
            }
            title = "Game Over!"
            message = "you ve lost"
            showAlert(title,message)
        }
    }
    
    func showAlert(_ title: String,_ message: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

