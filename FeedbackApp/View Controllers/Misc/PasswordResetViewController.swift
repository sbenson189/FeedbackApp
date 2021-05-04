//
//  PasswordResetViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/25/21.
//

import UIKit

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var successNotificationLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateFieldEntry () -> Bool {
        let usernameEntry = usernameField.text
        let passwordEntry = usernameField.text
        
        if  (usernameEntry!.count <= 0) || passwordEntry!.count <= 0 {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func submitPasswordReset(_ sender: Any) {
        
        let enteredData = [
            "username": usernameField.text,
            "password": passwordField.text
        ]

        if !validateFieldEntry() {
            successNotificationLabel.textColor = UIColor.red
            successNotificationLabel.text = "Username and password cannot be empty"
        } else {
            DBHelper.inst.updateUser(object: enteredData as! [String : String])
            successNotificationLabel.textColor = UIColor.green
            successNotificationLabel.text = "Password Has Been Reset"
            usernameField.text = ""
            passwordField.text = ""
        }
    }
}
