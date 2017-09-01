//
//  Friend.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-30.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Friend: NSObject {
    public var fid: String!
    public var name: String?
    public var addedTime: Date?
    
    init(fid: String!, name: String?, addedTime: Date?) {
        self.fid = fid
        self.name = name
        self.addedTime = addedTime
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Friend {
            return self.fid == object.fid
        }
        return false
    }
    
    override var hash: Int {
        return fid.hashValue
    }
    
    public func fetchName(completion: @escaping (_ name: String?) -> Void) {
        let userRef = Database.database().reference().child("users_by_uid").child(self.fid)
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            let val = snapshot.value as? NSDictionary
            self.name = val?["username"] as? String
            completion(self.name)
        })
    }
    
    public static var list = [Friend]()
}
