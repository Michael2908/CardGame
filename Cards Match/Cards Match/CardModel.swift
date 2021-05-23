import Foundation

class CardModel  {
    

    func getCards() -> [Card] {
        
        var generatedNumbersArray = [Int]()
        
        var generatedCardArray = [Card]()

        
        
        while generatedNumbersArray.count < 8 {
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
        
        return generatedCardArray
    }
    
}
