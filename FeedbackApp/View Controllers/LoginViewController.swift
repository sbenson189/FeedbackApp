//
//  LoginViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/25/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var invalidCredentialsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        
        usernameField.text = userDef.string(forKey: "rememberedUsername")
        passwordField.text = userDef.string(forKey: "rememberedPassword")
        if userDef.bool(forKey: "switchBool") {
            rememberMeSwitch.isOn = true
        }
//        DBHelper.inst.createRoomForFeedback(roomNumber: 100)
//        DBHelper.inst.addRoomForUser(object: ["username": "scott"], room: 100)

        SplashScreenViewController.timer.invalidate()
    }

    // -- Remember Me --
    let userDef = UserDefaults.standard
    @IBAction func rememberMeState(_ sender: UISwitch) {
        if sender.isOn {
            userDef.set(usernameField.text, forKey: "rememberedUsername")
            userDef.set(passwordField.text, forKey: "rememberedPassword")
        } else {
            userDef.removeObject(forKey: "rememberedUsername")
            userDef.removeObject(forKey: "rememberedPassword")
        }
        userDef.set(rememberMeSwitch.isOn, forKey: "switchBool")
    }
    
    // -- Login --
    func validateLoginInfo (enteredUsername : String, enteredPassword: String, dbUsername : String, dbPassword : String) -> Bool {
        if enteredUsername == dbUsername && enteredPassword == dbPassword {
            return true
        } else {
            return false
        }
    }

    @IBAction func submitLogin(_ sender: UIButton) {

        invalidCredentialsLabel.text = ""

        // -- Storyboard for Successful Login --
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardBoard = mainBoard.instantiateViewController(withIdentifier: "dashboard2") as! DashboardV2ViewController

        // -- Credentials entered by the user --
        let enteredUsername = usernameField.text!
        let enteredPassword = passwordField.text!

        // -- User info retrieved from DB --
        let retrievedUser = DBHelper.inst.getSingleUser (username: enteredUsername)
        if DBHelper.found == 0 {
            let retrievedUsername = retrievedUser.username!
            let retrievedPassword = retrievedUser.password!
            DBHelper.inst.currentUser = retrievedUsername
            
            // -- Pass in entered and retrieved username and password for validation, login if valid. --
            if validateLoginInfo(enteredUsername: enteredUsername, enteredPassword: enteredPassword, dbUsername: retrievedUsername, dbPassword: retrievedPassword) {
                // -- Present dashboard --
                self.navigationController?.pushViewController(dashboardBoard, animated: true)
            } else {
                invalidCredentialsLabel.text = "Invalid login credentials"
                passwordField.text = ""
            }
        } else {
            print("user not found")
            invalidCredentialsLabel.text = "Invalid login credentials"
            passwordField.text = ""
        }
    }

}
