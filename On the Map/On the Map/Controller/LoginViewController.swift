//
//  ViewController.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/5/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
       
        if let username = emailTextField.text, let password =  passwordTextField.text
        {
        let credintials = UdacityCredentials(username: username, password: password)
            UdacityClient.login(credentials: credintials) { (response) in
                if response.account?.registered == true {
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                }
                else if response.status == 403 {
                    self.setLoggingIn(false)
                    self.showAlert(message: "Incorrect Username/Password")
                }
                else
                {
                   self.setLoggingIn(false)
                    self.showAlert(message: "Login Failure. Reason: \(String(describing: response.error))")
                }
            }
        }
        else
        {
            self.setLoggingIn(false)
            showAlert(message: "Username and password cannot be empty")
        }
        
    }
    
   
    
    func setLoggingIn(_ loggingIn: Bool) {
        
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        
    }
    
}

extension UIViewController {
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
