//
//  MonsterImg.swift
//  mylittlemonster
//
//  Created by edward hsu on 2/14/16.
//  Copyright © 2016 Edward Hsu. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    // satisfy potential problems,
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // overriding initializers to calling the super ones
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // on initialization, when app first loads:
        playIdleAnimation()
    }
    
    
    func playIdleAnimation() {
        
        // default idle image for idle animation:
        self.image = UIImage(named: "idle1.png")
        
        self.animationImages = nil
        
        
        
        // An array of UIImage objects to use for an animation.
        // monsterImg.animationImages
        
        // could do:
        //        var img1 = UIImage(named: "idle1.png")
        
        // instead, create a for loop:
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            // in this case you can trust to include an ! because there will definitely be an img.
            imgArray.append(img!)
        }
        
        
        // "we inherited things, so call self to grab those things" UIImageView has these properties, so instead of "monsterImg.animation..." we have "self.animation..." 
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        // default image; what is shown after death loop:
        self.image = UIImage(named: "dead5.png")
        
        // clears everything, so the new appends below won't add onto idle.
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "dead\(x).png")
            // in this case you can trust to include an ! because there will definitely be an img.
            imgArray.append(img!)
        }
        
        
        // "we inherited things, so call self to grab those things" UIImageView has these properties, so instead of "monsterImg.animation..." we have "self.animation..."
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    
}