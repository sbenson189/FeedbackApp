//
//  ThankYouViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/20/21.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeButton: UIButton!
    
    let currentUser = DBHelper.inst.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        codeLabel.text = codeGenerator(length: 12)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
    }
    
    @IBAction func copyCode(_ sender: Any) {
        UIPasteboard.general.string = codeLabel.text
        print(codeLabel.text!)
    }
    
    func codeGenerator(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let code = String((0..<length).map{ _ in letters.randomElement()! })
        DBHelper.inst.addUserCode(object : ["username" : currentUser], code: code)
        return code
    }
    
    @IBAction func returnToDashboard(_ sender: UIButton) {
        DBHelper.inst.addRoomForUser(object: ["username": DBHelper.inst.currentUser], room: 0)
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardBoard = mainBoard.instantiateViewController(withIdentifier: "dashboard2") as! DashboardV2ViewController
        self.navigationController?.pushViewController(dashboardBoard, animated: true)
    }
}
