//
//  ViewController.swift
//  mylittlemonster
//
//  Created by edward hsu on 2/11/16.
//  Copyright © 2016 Edward Hsu. All rights reserved.
//

import UIKit

// this code contains the audioplayer:
import AVFoundation



class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var monsterImg: MonsterImg!
    // instead of UIImageView, now MonsterImg (after MonsterImg class was created)
    
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet weak var penalty1Img: UIImageView!
    
    @IBOutlet weak var penalty2Img: UIImageView!
    
    @IBOutlet weak var penalty3Img: UIImageView!
    
    
    // 1.0 is full opacity
    // full caps = constant for everyone
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    
    // will know we will use for sure, so implicitly unwrapped with !
    var timer: NSTimer!
    
    // everytime feed monster he becomes happy (true). Otherwise lose a life through penalty.
    var monsterHappy = false
    
    // 32 bit integer can hold more values, unsigned, can hold more than normal Int
    var currentItem: UInt32?
    
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        
        
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
        
        
        // if we load a file, it may not load anything. Must have try keyword in front of musicplayer, or else it won't work.
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            // this is equivalent to:
            /*
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            */
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("biteSound", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heartSound", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("deathSound", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skullSound", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
        
        startTimer()
        
    }
    
    
    
    // need to create function in case the notification goes off:
    // AnyObject means it can be any object can be passed into it, do not need to worry about specific type
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("ITEM DROPPED ON CHARACTER")
        // testing 3 things: let go item, 1. did it detect that you dropped on monster, 2. is notification working, 3. is the function being called?
        
        monsterHappy = true
        
        
        if penalties >= 1 {
            
            penalties--
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
        }
        
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    
    func startTimer() {
        
        // if there's an existing running timer (not nil), before starting the new one, stop the existing one.
        if timer != nil {
            timer.invalidate()
        }
        
        // function called has no parameters, so changeGameState doesn't need ":"
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        
        
        if !monsterHappy {
            
            penalties++
            
            sfxSkull.play()
            
            // ensure that the next one has a dimmed alpha, which is why DIM_ALPHA is stated again.
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
        }

        
        // give a random number from range from 0 to 1
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            //            foodImg.alpha = DIM_ALPHA
            //            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            //            heartImg.alpha = DIM_ALPHA
            //            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        
        // reset to false and need to make him happy again
        monsterHappy = false
        
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    
    func gameOver() {

        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
    }

}

