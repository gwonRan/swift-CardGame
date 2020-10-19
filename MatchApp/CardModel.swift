//
//  CardModel.swift
//  MatchApp
//
//  Created by 권미란 on 2020/10/17.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        //[Card]는 data type is an array that contains card object
        
        //Declare an empty array
        var generatedCards = [Card]()
        //()는 data type just creates a new array object
        
        //Randomly generate 8 pairs of cards
        for _ in 1...8 {
            
            //Generate a random number
            let randomNumber = Int.random(in: 1...13)
            //카드는 1부터 13까지 존재해
            print("generating a random number \(randomNumber)")
            
            //Create two new card objects
            let cardOne = Card()
            let cardTwo = Card()
            
            //Set their image names
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            //Add them to the array
            generatedCards += [cardOne, cardTwo]
            
        }
        
        //Randomize the cards within the array
        generatedCards.shuffle()
        print(generatedCards.count)

        //Return the array
        return generatedCards
        
    }
    
}
