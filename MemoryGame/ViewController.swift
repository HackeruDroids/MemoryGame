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
//        let img = sender.image(for: .highlighted)
//        //sender.setImage(img, for: .normal)
//        sender.setImage(img, for: .disabled)
        sender.isEnabled = false
        
        if previousButton == nil{
            //first card...
            //save the previous button
            previousButton = sender
        }else{
            
            //explicitly unwrapped optional.
            //let p:UIButton = previousButton!
            
            // let img: UIImage? = previousButton?.image(for: .disabled)
            
            //we have 2 buttons: //sender, previous button
            if previousButton?.image(for: .disabled) == sender.image(for: .disabled){
                print("Good")
            }else{
                print("Bad")
                sender.isEnabled = true
                previousButton?.isEnabled = true
            }
            
            previousButton = nil
            //lets compare the images...
            //print(Good, Bad)
            //previous button = nil
        }
    }
    
    
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

