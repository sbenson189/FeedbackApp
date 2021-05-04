//
//  DashboardV2ViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/27/21.
//

import UIKit

class DashboardV2ViewController: UIViewController {

    @IBOutlet weak var roomButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let code = DBHelper.inst.getUserCode(username: DBHelper.inst.currentUser)
        codeButton.setTitle(code, for: .normal)
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        
        let currentUser = DBHelper.inst.currentUser
        self.userLabel.text = "Hello \(currentUser)"
        let roomNumber = DBHelper.inst.getUserRoomNumber(object: ["username" : currentUser])
        if roomNumber == 0 {
            roomButton.setTitle("No reviews available", for: .disabled)
            roomButton.isEnabled = false
            instructionLabel.text = """
                Please contact the us at:
                1800-Astora(278-672)
                to have your room assigned.
            """
        } else {
            let convertedRoomNumber = String(roomNumber)
            roomButton.setTitle(convertedRoomNumber, for: .normal)
            instructionLabel.text = "Tap room number to leave feedback."
        }
    }

    @IBAction func copyCode(_ sender: UIButton) {
        UIPasteboard.general.string = codeButton.title(for: .normal)
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        DBHelper.inst.currentUser = ""
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginBoard = mainBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(loginBoard, animated: true)
    }
}
