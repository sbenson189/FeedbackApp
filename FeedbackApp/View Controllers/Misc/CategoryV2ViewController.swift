//
//  CategoryV2ViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/29/21.
//

import UIKit

class CategoryV2ViewController: UIViewController {
    
    @IBOutlet weak var gymButton: UIButton!
    @IBOutlet weak var poolAndSpaButton: UIButton!
    @IBOutlet weak var roomServiceButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var overallButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    
    var validSubmission = false

    override func viewDidLoad() {
        super.viewDidLoad()
        validateCategories()

        if gymStatus > 4 {
            gymButton.isEnabled = false
            gymButton.setTitleColor(UIColor.black, for: .disabled)
            gymButton.setTitle("Gym (Complete)", for: .disabled)
            gymButton.alpha = 0.1
        } else {
            validSubmission = false
        }
        if roomServiceStatus > 4 {
            roomServiceButton.isEnabled = false
            roomServiceButton.setTitleColor(UIColor.black, for: .disabled)
            roomServiceButton.setTitle("Room Service (Complete)", for: .disabled)
            roomServiceButton.alpha = 0.1
        } else {
            validSubmission = false
        }
        if foodStatus > 4 {
            foodButton.isEnabled = false
            foodButton.setTitleColor(UIColor.black, for: .disabled)
            foodButton.setTitle("Food (Complete)", for: .disabled)
            foodButton.alpha = 0.1
        } else {
            validSubmission = false
        }
        if overallStatus > 4 {
            overallButton.isEnabled = false
            overallButton.setTitleColor(UIColor.black, for: .disabled)
            overallButton.setTitle("Overall (Complete)", for: .disabled)
            overallButton.alpha = 0.1
        } else {
            validSubmission = false
        }
        if poolAndSpaStatus > 4 {
            poolAndSpaButton.isEnabled = false
            poolAndSpaButton.setTitleColor(UIColor.black, for: .disabled)
            poolAndSpaButton.setTitle("Pool and Spa (Complete)", for: .disabled)
            poolAndSpaButton.alpha = 0.1
        } else {
            validSubmission = false
        }
    }
    
    let mainBoard = UIStoryboard(name: "Main", bundle: nil)
    
    var gymStatus = DBHelper.gymReviewScore
    var roomServiceStatus = DBHelper.roomServiceReviewScore
    var foodStatus = DBHelper.foodReviewScore
    var poolAndSpaStatus = DBHelper.poolAndSpaReviewScore
    var overallStatus = DBHelper.overallReviewScore
    
    func checkCompleteStatus () {
        if DBHelper.gymComplete == true && DBHelper.roomServiceComplete == true && DBHelper.poolAndSpaComplete == true && DBHelper.foodComplete == true && DBHelper.overallComplete == true {
            validSubmission = true
        } else {
            validSubmission = false
        }
    }

    func validateCategories () {
        checkCompleteStatus()
        if !validSubmission {
            submitButton.isEnabled = false
            warningLabel.text = "All categories not complete"
            submitButton.alpha = 0.1
        } else {
            print("dadasd")
            warningLabel.text = "Review complete, click submit!"
            warningLabel.textColor = .green
        }
    }
    
    @IBAction func gymClicked(_ sender: Any) {
        let gymBoard = mainBoard.instantiateViewController(withIdentifier: "gym") as! GymPageViewController
        self.navigationController?.pushViewController(gymBoard, animated: true)
    }
    
    @IBAction func poolAndSpaClicked(_ sender: Any) {
        let poolAndSpaBoard = mainBoard.instantiateViewController(withIdentifier: "poolAndSpa") as! PoolAndSpaPageViewController
        self.navigationController?.pushViewController(poolAndSpaBoard, animated: true)
    }
    
    @IBAction func roomServiceClicked(_ sender: Any) {
        let roomServiceBoard = mainBoard.instantiateViewController(withIdentifier: "roomService") as! RoomServicePageViewController
        self.navigationController?.pushViewController(roomServiceBoard, animated: true)
    }
    
    @IBAction func foodClicked(_ sender: Any) {
        let foodBoard = mainBoard.instantiateViewController(withIdentifier: "food") as! FoodPageViewController
        self.navigationController?.pushViewController(foodBoard, animated: true)
    }
    
    @IBAction func overallClicked(_ sender: Any) {
        let overallBoard = mainBoard.instantiateViewController(withIdentifier: "overall") as! OverallPageViewController
        self.navigationController?.pushViewController(overallBoard, animated: true)
    }

    @IBAction func submitReviewToDB(_ sender: UIButton) {
        if !validSubmission {
            print("no")
        } else {
            let overallBoard = mainBoard.instantiateViewController(withIdentifier: "thankYou") as! ThankYouViewController
            self.navigationController?.pushViewController(overallBoard, animated: true)
        }
    }
}
