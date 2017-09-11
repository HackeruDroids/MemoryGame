//
//  ViewController.swift
//  MemoryGame
//
//  Created by TomerBu on 11/09/2017.
//  Copyright © 2017 TomerBu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let allImages = [#imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "jiraf"), #imageLiteral(resourceName: "shark"), #imageLiteral(resourceName: "tiger"), #imageLiteral(resourceName: "lion"), #imageLiteral(resourceName: "owl")]
    
    //game images:
    var gameImages:[UIImage] = []
    
    //get a random number from 0(inclusive) to max (exclusive)
    func rand(max: Int) -> Int{
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    @IBOutlet var cards: [UIButton]!

 
    
    var previousButton:UIButton?
    
    @IBAction func cardTapped(_ sender: UIButton) {
        sender.isEnabled = false //show disabled image and the button is not clickable!
        //first card...
        if previousButton == nil{
            previousButton = sender //save the previous button
        }else{
            //if the images match:
            if previousButton?.image(for: .disabled) == sender.image(for: .disabled){
                print("Good")
            }else{
//                print("Bad")
//                sender.isEnabled = true
//                previousButton?.isEnabled = true
                
                
               //A)
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    sender.isEnabled = true
                    self.previousButton?.isEnabled = true
                    //self.previousButton = nil
               })
            }
            
            //B)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.previousButton = nil
            })
        }
    }
    
    //1) write 2 functions A) And B)
    //2) refactor all the code to work with readable ,  maintainable methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var gameSet:Set<UIImage> = []
        
        while gameSet.count < cards.count / 2 {
            gameSet.insert(allImages[rand(max: allImages.count)])
        }
        gameImages.append(contentsOf: gameSet)
        gameImages += gameImages
     
        //shuffle the array:
        cards.sort { (_, _) -> Bool in
            return randBoolean()
        }
        
        for card in cards{
            //let idx = rand(max: gameImages.count)
            card.setImage(gameImages.remove(at: 0), for: .disabled)
        }
    }

    func randBoolean()-> Bool{
        return rand(max: 2) == 0
//        if r == 0{
//            return true
//        }else{
//            return false
//        }
        //return r == 0 ? true : false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

