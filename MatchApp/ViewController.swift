//
//  ViewController.swift
//  MatchApp
//
//  Created by 권미란 on 2020/10/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //UICollectionViewDelegate protocol here there are no required methods. 여러 프로토콜 중 내가 원하는 채택 작업
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        //Set the view controller as the datasource and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        //위임자가 누구인지 알려주는 과정
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //called collection view asking the view controller how many items do you want me to display
        //Return numver of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //you can tell them apart
        //Get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        //dequeueReusableCell는 데이터 타입을 모른다. 시스템에 이 개체를 다른 유형으로 처리하도록 지시해야한다 collectionViewCell = casting
        //I am sure that this object is this type or I'm not so sure that this is that type
        //scroll로 인해 화면에 보여주기 전의 상태 대기열
        
        //Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        // Finish configuring the cell
        cell.configureCell(card: card)
        
        //Return it
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        //Check the status of the card to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            //Flip the card up
            cell?.flipUp()
            
            //Check if this is the frist card that was flipped or the second card
            if firstFlippedCardIndex == nil {
                
                //뒤집힌 첫번째 카드
                firstFlippedCardIndex = indexPath
                
            }
            else {
                
                //Second card that is flipped
                
                //Run the comparison
                checkForMatch(indexPath)
                
            }
        }
    }
    
    // MARK: - Game Logic Methods
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        
        //Get the two card objecs for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[firstFlippedCardIndex!.row]
        //second flipped card index is not an optional type
        
        //Get the two collection view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        //Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            //It's a match
            
            //Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }
        else {
            
            //It's not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
        }
        
        //Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
        
    }
    
}

