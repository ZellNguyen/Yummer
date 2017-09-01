//
//  RestaurantViewModel.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-14.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class RestaurantViewModel {
    var restaurants = [Restaurant]()
    var imageRefs = [StorageReference]()
    
    var delegate: NetworkDelegate? = nil
    
    static let TAG: String! = "RESTAURANTVIEWMODEL"
    
    // MARK: Shared Instance
    static let shared: RestaurantViewModel = {
        let instace = RestaurantViewModel()
        return instace
    }()
    
    private func fetch(completion: @escaping (Int) -> ()) {
        let restaurantsRef = Database.database().reference().child("restaurants")
        
        restaurantsRef.observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let rid = snapshot.key
            
            if Decision.main.picked.contains(rid) || Decision.main.passed.contains(rid) {
                return
            }
            
            let image = value?["image"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let openHour = value?["open_hour"] as? String ?? ""
            
            let restaurant = Restaurant(rid: rid, name: name, imageURL: image, openHour: openHour)
        
            self.restaurants.append(restaurant)
            self.imageRefs.append(self.loadImage(fromURL: image))
            
            // Callback after the data was loaded
            completion(self.restaurants.count - 1)
        })
    }
    
    private func loadImage(fromURL url: String) -> StorageReference {
        // Point to the Firebase Storage
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child(url)
        
        return imageRef
    }
    
    public func load() {
        self.fetch(completion: { index in
            self.delegate?.onRetrieved(resultAtIndex: index)
        })
    }
    
    public func skip(at index: Int){
        Decision.main.appendToPicked(with: self.restaurants[index].rid)
        self.restaurants.remove(at: index)
        self.imageRefs.remove(at: index)
    }
    
    public func pick(at index: Int){
        Decision.main.appendToPicked(with: self.restaurants[index].rid)
        self.restaurants.remove(at: index)
        self.imageRefs.remove(at: index)
    }
    
    public func restaurantName(byRid rid: String!) -> String? {
        let ref = Database.database().reference().child("restaurants").child(rid)
        var name: String? = nil
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            name = value?["name"] as? String
        })
        
        return name
    }
}
