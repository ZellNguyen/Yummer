//
//  CardView.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-23.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public var delegate: CardViewDelegate? = nil
    public var index: Int? = nil
    private var origin: CGPoint? = nil
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


    @IBAction func viewWasDragged(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began || sender.state == UIGestureRecognizerState.changed {
            
            // How far the touch pans
            let translation = sender.translation(in: self)
            
            // Move the view based on the translation
            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
            
            // Reset translation
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
        
        if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            UIView.animate(withDuration: 0.2, animations: {
                
                // Call Delegate Methods and remove from superview if went out of range
                let minX = self.origin!.x - self.frame.width/2
                let maxX = self.origin!.x + self.frame.width/2
                
                // Swipe Left
                if self.center.x < minX {
                    self.delegate?.swipe(.left, forCardAt: self.index!)
                    self.removeFromSuperview()
                    return
                }
                    
                // Swipe Right
                if self.center.x > maxX {
                    self.delegate?.swipe(.right, forCardAt: self.index!)
                    self.removeFromSuperview()
                    return
                }
                
                // Not going out of range, reset position
                self.center = self.origin!
            })
        }
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: 0.1, animations: {
            self.center = CGPoint(x: self.center.x + (self.center.x - self.origin!.x), y: self.center.y + (self.center.y - self.origin!.y))
        }, completion: { error in
            super.removeFromSuperview()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.origin = self.center
    }
    
    func duplicate() -> CardView {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! CardView
    }
}

protocol CardViewDelegate {
    func swipe(_ direction: SwipeDirection, forCardAt index: Int)
}

enum SwipeDirection {
    case left, right, up, down
}
