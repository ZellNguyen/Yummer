//
//  RestaurantList.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-13.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class Restaurant {
    var rid: String!
    var name: String?
    var imageURL: String?
    var openHour: String?
    var isOpen: Bool? = false
    
    init(rid: String!, name: String?, imageURL: String?, openHour: String?) {
        self.rid = rid
        self.name = name
        self.imageURL = imageURL
        self.openHour = openHour
    
        self.isOpen = self.checkIfOpen(at: Date())
    }
    
    private func checkIfOpen(at time: Date!) -> Bool {
        let openHourString = self.openHour?.components(separatedBy: "-")
        
        let openTimeString: String? = openHourString?[0]
        let closeTimeString: String? = openHourString?[1]
        
        let currentHour = Calendar.current.component(.hour, from: time)
        let currentMin = Calendar.current.component(.minute, from: time)
        
        let currentTime = [Int(currentHour), Int(currentMin)]
        
        guard openTimeString != nil && closeTimeString != nil else {
            let openTime = self.timeToInteger(from: openTimeString)
            let closeTime = self.timeToInteger(from: closeTimeString)
            
            return (self.after(first: currentTime, second: openTime!) && !self.after(first: currentTime, second: closeTime!))
        }
        
        return false
    }
    
    private func timeToInteger(from timeString: String!) -> [Int]? {
        let timeStrings = timeString.components(separatedBy: ":")
        
        let hourString: String? = timeStrings[0]
        let minuteString: String? = timeStrings[1]
        
        if let hourString = hourString, let minuteString = minuteString {
            let hourInt = Int(hourString)
            let minuteInt = Int(minuteString)
            return [hourInt!, minuteInt!]
        }
        
        return nil
    }
    private func after(first: [Int], second: [Int]) -> Bool {
        if first[0] > second[0] { return true }
        else if first[0] < second[0] { return false }
        
        return first[1] >= second[1]
    }
    
}
