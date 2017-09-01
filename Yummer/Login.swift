//
//  Login.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-11.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

class Login {
    var email: String?
    var password: String?
    var uid: String?
    
    static let TAG: String = "LOGIN"
    
    public var active: Bool! = false {
        didSet {
            NetworkManager.status = "\(Login.TAG).DONE"
        }
    }
    
    private init(email: String?, password: String?, uid: String?) {
        self.email = email
        self.password = password
        self.uid = uid
    }
    
    // MARK: Shared Instance
    static let current: Login = {
        let instace = Login(email: nil, password: nil, uid: nil)
        return instace
    }()
    
    func update(email: String!, password: String!, uid: String!) {
        self.email = email
        self.password = password
        self.uid = uid
    }
}
