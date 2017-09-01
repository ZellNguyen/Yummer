//
//  FriendViewModel.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-27.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FeedViewModel {
    public var feed = [Post]()
    public var delegate: NetworkDelegate? = nil

    private func fetch(completion: ((_ sender: Post) -> Void)! ){
        let feedRef = Database.database().reference().child("feeds_by_id").child(Login.current.uid!)
        feedRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let val = child.value as? NSDictionary
                let post = Post(friend: nil, rids: [String](), lastActive: nil)
                
                // Load restaurant IDs
                for index in 0..<Int(child.childrenCount-1) {
                    post.rids?.append(val?.allValues[index] as? String ?? "")
                }
                
                // Load last active
                let lastActive = TimeInterval( Date().toTimeStamp() - Int(val?["lastActive"] as! String)! )
                post.lastActive = lastActive
                
                // Load friend name
                let friend = Friend(fid: child.key, name: nil, addedTime: nil)
                friend.fetchName(completion: { name in
                    friend.name = name
                    post.friend = friend
                    completion(post)
                })
            }
        })
    }
    
    public func fetch() {
        self.fetch(completion: { post in
            self.feed.append(post)
            print(self.feed.count)
            self.delegate?.onRetrieved(resultAtIndex: self.feed.count - 1)
        })
    }
}

extension TimeInterval {
    func toString() -> String {
        if self < 60 {
            return "now"
        }
        if self < 3600 {
            return "\(String(Int((self/60).rounded(.towardZero))))m ago"
        }
        if self < 86400 {
            return "\(String(Int((self/3600).rounded(.towardZero))))h ago"
        }
        else {
            return "\(String(Int((self/86400).rounded(.towardZero))))d ago"
        }
    }
}
