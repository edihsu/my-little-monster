//
//  DragImg.swift
//  mylittlemonster
//
//  Created by edward hsu on 2/11/16.
//  Copyright © 2016 Edward Hsu. All rights reserved.
//

import Foundation
import UIKit

// Instead of regular UIImageView, can use this custom DragImg version to write some custom stuff.
// :UIImageView extends from UIImageView (inherits all of UIImageView's features)
class DragImg: UIImageView {
    
    
    // store beginning position. where things will return back to if bad drag.
    var originalPosition: CGPoint!
    
    // a target to allow the dragged item to be released upon:
    // We know he is an image, but we don't want to be limited to the dropTarget to be UIImage, so we make a it a UIView intead (thinking for the future). UIView is a base class:
    var dropTarget: UIView?
    
    
    // let ON_TARGET_DROPPED: NSNotification = NSNotification(name: "onTargetDropped", object: nil)
    
    
    
    // forced to use initializers:
    
    
    // UIImageView has its own initializers, so this will override it:
    // override init(frame:CGRect) Initializes and returns a newly allocated view object with the specified frame rectangle.
    // An initialized view object or nil if the object couldn't be created.
    override init(frame: CGRect) {
        // need to call parent initializer:
        super.init(frame: frame)
        
    }
    
    // pass up aDecoder to the super init.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // above two initialization methods are called before layouts are laid out on screen, so cannot guaranteed center will correct. May be null or empty!
    
    
    
    
    // touch methods:
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        

        // this is where center can be guaranteed, not in the initializers above:
        originalPosition = self.center
    }
    
    
    
    
    // moving, moves object
    // "passes in Set of 'touches'"
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // grab first touch that is in Set
        if let touch = touches.first {
            // grab location of where finger touched in the view (of the superview)
            let position = touch.locationInView(self.superview)
            
            //
            // Move imageView center, move the center to the new position
            // Wherever the finger is dragging (position x and y), move the object (center)
            // CGPointMake makes a point from the touch's position
            self.center = CGPointMake(position.x, position.y)
        }
        
    }
    
    
    
    // touches ended - need this to tell if you've dropped the view on the character or not:
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget {
            // to make sure that there is an item to be dropped upon, to validate the ? in the dropTarget property declared above.
        
            let position = touch.locationInView(self.superview)
            
            // see if the image we've dragged is anywhere over the rectangle:
            // rectangle frame is the monster ("did your touch land there?"); pass in the touch, which is the position, and applied to the dragged object
            if CGRectContainsPoint(target.frame, position) {
                
                
                // calling the service called NSNotificationCenter, grabbing the defaultCenter, then postingNotifcation which takes parameter NSNotification
                // same as: var notif = NSNotification(name: "onTargetDropped, object: nil"
                // we did it in line to save space.
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                
                // NSNotificationCenter.defaultCenter().postNotification(ON_TARGET_DROPPED)
                

                
                
            }
        }
        
        self.center = originalPosition
        
        
        
        
        //        if let touch = touches.first {
//            
//        }
    }
}