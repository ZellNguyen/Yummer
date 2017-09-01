//
//  ViewController.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-11.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var authListener: AuthStateDidChangeListenerHandle? = nil
    
    //MARK: Outlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func logInDidTouch(_ sender: Any) {
        LoginViewModel.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        self.authListener = Auth.auth().addStateDidChangeListener( { auth, user in
            
            // If user signed in
            
            if user != nil {
                print(user?.email)
                self.performSegue(withIdentifier: "LoginToDeckViewSegue", sender: nil)
            }
        } )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(self.authListener!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

