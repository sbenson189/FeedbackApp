//
//  SignUpViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/25/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var accountCreatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpSubmitted(_ sender: Any) {
        
        let enteredData = [
            "firstName": firstNameField.text,
            "lastName": lastNameField.text,
            "email": emailField.text,
            "phoneNumber": phoneNumberField.text,
            "username": usernameField.text,
            "password": passwordField.text
        ]
        
        DBHelper.inst.addUserData(object: enteredData as! [String : String])
        
        accountCreatedLabel.text = "Account created"
        firstNameField.text = ""
        lastNameField.text = ""
        emailField.text = ""
        phoneNumberField.text = ""
        usernameField.text = ""
        passwordField.text = ""
        
    }
}
