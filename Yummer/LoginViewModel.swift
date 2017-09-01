//
//  LoginViewModel.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-11.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class LoginViewModel {
    
    static func signUp(email: String!, password: String!, username: String!, completion: @escaping (Error) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                // Sign in
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        Login.current.update(email: email, password: password, uid: user?.uid)
                        self.store(username: username!)
                        Login.current.active = true
                    }
                })
            } else {
                completion(error!)
            }
        }
    }
    
    static func login(email: String!, password: String!) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                Login.current.update(email: email, password: password, uid: user?.uid)
                Login.current.active = true
            } else {
                print(error.debugDescription)
            }
        })
    }
    
    private static func store(username: String!) {
        let usernameRef = Database.database().reference().child("users_by_uid")
        usernameRef.child(Login.current.uid!).child("username").setValue(username)
    }
}
