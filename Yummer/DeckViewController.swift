//
//  DeckViewController.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-13.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI
import FirebaseAuth

class DeckViewController: UIViewController, NetworkDelegate, CardViewDelegate {
    
    var restaurantViewModel = RestaurantViewModel.shared
    
    @IBOutlet var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantViewModel.delegate = self
        
        // Do any additional setup after loading the view.
        
        // Load restaurants database after logged in
        
        overlayView.backgroundColor = UIColor.cyan
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onRetrieved(resultAtIndex index: Int) {
    
        let cardView = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardView
        
        cardView.delegate = self
        
        cardView.index = index
        
        // REQUIRED: to add constraint programmatically
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Update Name label
        let name = restaurantViewModel.restaurants[index].name
        cardView.label.text = name
        
        // Lazy load to imageView
        let imageRef = restaurantViewModel.imageRefs[index]
        let placeholderImage = UIImage(named: "placeholder")
        cardView.image.sd_setImage(with: imageRef, placeholderImage: placeholderImage)
        
        overlayView.addSubview(cardView)
        
        // Set up Constraint
        let topConstraint = NSLayoutConstraint(item: cardView, attribute: .top, relatedBy: .equal, toItem: overlayView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: overlayView, attribute: .bottom, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: overlayView, attribute: .leading, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: overlayView, attribute: .trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
    }
    
    func swipe(_ direction: SwipeDirection, forCardAt index: Int) {
        switch direction {
        case .left:
            restaurantViewModel.skip(at: index)
        case .right:
            restaurantViewModel.pick(at: index)
        default:
            return
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
