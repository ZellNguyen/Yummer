//
//  SignUpViewController.swift
//  Yummer
//
//  Created by Hoa Nguyen on 2017-06-11.
//  Copyright © 2017 Hoa Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var authListener: AuthStateDidChangeListenerHandle? = nil
    
    // MARK: Outlets
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for textField in self.view.subviews where textField is UITextField {
            if let textField = textField as? UITextField {
                textField.delegate = self
            }
        }
        
        self.authListener = Auth.auth().addStateDidChangeListener( { auth, user in
            
            // If user signed in
            
            if user != nil {
                self.performSegue(withIdentifier: "SignUpToDeckPageSegue", sender: nil)
            }
        } )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(self.authListener!)
    }
    
    @IBAction func joinDidTouch(_ sender: Any) {
        if passwordTextField.text! == confPassTextField.text!  {
            LoginViewModel.signUp(email: emailTextField.text!, password: passwordTextField.text!, username: userNameTextField.text!, completion: { (error) in
                self.showErrorAlert(error: error)
            })
        }
    }
    
    func showErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text field Delegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
