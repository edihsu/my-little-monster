//
//  ViewController.swift
//  mylittlemonster
//
//  Created by edward hsu on 2/11/16.
//  Copyright © 2016 Edward Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var monsterImg: MonsterImg!
    // instead of UIImageView, now MonsterImg (after MonsterImg class was created)
    
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet weak var penalty1Img: UIImageView!
    
    @IBOutlet weak var penalty2Img: UIImageView!
    
    @IBOutlet weak var penalty3Img: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        
        
        // Become the observer (This class will listen for it)
        // observer for the notification from dragged objects (touches ended) from the DragImg class
        /* 
        1. observer is self, means this class will listen for it
        2. selector is function that you will call, "itemDroppedOnCharacter:" 
            : means one or more parameters. If colon is not there, it will look for function with no parameters.
            and NSNotifications pass in a Notification object pareameter, must have colon or function will not be called.
            This is a common mistake when learning iOS.
        3. "onTargetDropped" is the name of the notificaiton, named before in DragImg class
        4. No object, nil.
        */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "\(DragImg.ON_TARGET_DROPPED.name)", object: nil)
        
    
    }
    
    
    
    // need to create function in case the notification goes off:
    // AnyObject means it can be any object can be passed into it, do not need to worry about specific type
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("ITEM DROPPED ON CHARACTER")
        // testing 3 things: let go item, 1. did it detect that you dropped on monster, 2. is notification working, 3. is the function being called?
    }
    
    

//    // UIResponder > Passes to top level class, passes and forwarded it downward
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("I just touched the screen")
//    }
    
    
    


}

