import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
   
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var triesLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var difficulty = GameLevel.normal
    var cardArray = [Card]()
    var timer:Timer?
    var milliseconds:Float = 90*1000
    var tries = 0
    var pairs: Int = 8
    var timeDone : String = ""
    var maxTime : Float = 90*1000
    
    
    var firstFlippedCardIndex:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch difficulty{
        case GameLevel.easy:
            pairs = 4
            break
        case GameLevel.normal:
            pairs = 8
            break
        case GameLevel.hard:
            pairs = 12
            break
        }
        
        var generatedNumbersArray = [Int]()
        
        var generatedCardArray = [Card]()

        
        
        while generatedNumbersArray.count < pairs {
           let randomNumber =  arc4random_uniform(13) + 1
            
            if generatedNumbersArray.contains(Int(randomNumber)) == false{
                print(randomNumber)
                generatedNumbersArray.append(Int(randomNumber))
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardOne)
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                generatedCardArray.append(cardTwo)
                
            }
        
        }
        for i in 0...generatedCardArray.count - 1{
        let randomNumber = Int(arc4random_uniform(UInt32(generatedCardArray.count)))
        let temporaryStorage = generatedCardArray[i]
        generatedCardArray[i] = generatedCardArray [randomNumber]
        generatedCardArray[randomNumber] = temporaryStorage}
        
        
        cardArray = generatedCardArray
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func getPairs() -> Int{
        return pairs
    }
    

    // MARK: - Timer Methods
    
    @objc func timerElapsed(){
        
        milliseconds -= 1
        
        let seconds = String(format: "%.2f",milliseconds/1000)
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        if milliseconds <= 0{
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
        
    }
    
    
    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
  


    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if milliseconds <= 0{
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false{
            cell.flip()
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil{
                firstFlippedCardIndex = indexPath
            }
            else{
                checkForMatches(indexPath)
            }
        }
    }
    
    //MARK: - Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        let cardOneCell = CollectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = CollectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName{
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            tries += 1
            triesLabel.text = "Tries: \(tries)"
            
            
            checkGameEnded()
        }
        else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            tries += 1
            triesLabel.text = "Tries: \(tries)"
            
        }
        if cardOneCell == nil{
            CollectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        firstFlippedCardIndex = nil
        
        
    }
    
    func checkGameEnded(){
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        if isWon == true{
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            maxTime = maxTime - milliseconds
            timeDone = String(format: "%.2f",maxTime/1000)
            
            title = "Congratulations!"
            message = "You've Won"
            
        }
        else{
            
            if milliseconds > 0 {
                return
            }
            title = "Game Over"
            message = "You've Lost"
    
        }
       
        showAlert(title, message)
        
    }
    
    func showAlert(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}



