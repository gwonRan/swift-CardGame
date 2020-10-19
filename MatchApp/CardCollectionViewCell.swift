//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by 권미란 on 2020/10/17.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func configureCell(card: Card) {
        
        //keep track of the card this cell represent
        self.card = card
        
        //Set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        //Reset the state of the cell by checking the flipped status of the card and then showing the front or the back imageView accordingly
        if card.isFlipped == true {
            // Show the front image view
            flipUp(speed: 0)
        }
        else {
            // Show the back image view
            flipDown(speed: 0)
            
        }
        
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        
        //Set the status of the card
        card?.isFlipped = true
        
    }
    
    func flipDown(speed: TimeInterval = 0.3) {
        
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        
        
        card?.isFlipped = false
        
    }
    
    func remove() {
        
        //Make the image view invisible
        backImageView.alpha = 0
         
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
    
} 
