//
//  Post.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-07-02.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post {
    public var friend: Friend?
    public var rids: [String]?
    public var lastActive: TimeInterval?
    
    init(friend: Friend?, rids: [String]?, lastActive: TimeInterval?) {
        self.friend = friend
        self.rids = rids
        self.lastActive = lastActive
    }
}
