//
//  Profile.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-25.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Decision {
    var picked = NSMutableSet()
    var passed = NSMutableSet()
    
    static let TAG: String = "DECIDER"
    
    static let main: Decision = {
        let instace = Decision()
        return instace
    }()
    
    public func appendToPicked(with rid: String?){
        let ref = Database.database().reference().child("picked_by_id")
        self.picked.add(rid!)
        let timeStamp = String(Date().toTimeStamp())
        print("DECIDER: \(timeStamp)")
        ref.child(Login.current.uid!).child(timeStamp).setValue(rid!)
    }
    
    public func appendToPassed(with rid: String?) {
        let ref = Database.database().reference().child("passed_by_id")
        self.passed.add(rid!)
        let timeStamp = String(Date().toTimeStamp())
        ref.child(Login.current.uid!).child(timeStamp).setValue(rid!)
    }
}

extension Date {
    func toString(withFormat format: String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
    
    func toTimeStamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
    
    init(fromTimeStamp timeStamp: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(timeStamp))
    }
}
