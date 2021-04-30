//
//  GymPageViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/26/21.
//

import UIKit

class GymPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var invalidResponseLabel: UILabel!
    
    let answerOptions = ["", "Awful", "Needs Improvement", "Okay", "Good", "Outstanding"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answerOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        compileResponses(tag: pickerView.tag, response: row)
    }
    
    // resDict is a dictionary that stores user responses as [question(picker tag) : response(answer number))
        // An empty reponse equal 0
    // validResponse holds whether or not validator function has passed. Dictates saveResponses function results.
    var resDict = [Int: Int]()
    var validResponse = false
    var counter = 0
    
    func compileResponses(tag: Int, response: Int) {
        // function to compile all reponses and call the validator function with those responses.
        resDict[tag] = response
        let responseCount = resDict.count

        if !validateResponses(responseCount: responseCount, responses: resDict) {
            validResponse = false
        } else {
            validResponse = true
        }
    }
    
    func validateResponses (responseCount: Int, responses: Dictionary<Int, Int>) -> Bool {
        // Ensures all questions have been answered and updates warning label appropriately.
        for key in responses.values{
            if key == 0 {
                invalidResponseLabel.text = "Must answer all questions"
                return false
            } else if responseCount < 5 {
                invalidResponseLabel.text = "Must answer all questions"
                return false
            } else if key != 0 && responseCount == 5 {
                invalidResponseLabel.text = ""
            }
        }
        // If above checks pass, return true
        counter = responses.values.reduce(0,+)
        DBHelper.gymReviewScore = counter
        
        return true
    }
    
    @IBAction func saveResponses(_ sender: UIButton) {
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let categoriesBoard = mainBoard.instantiateViewController(withIdentifier: "category2") as! CategoryV2ViewController
        
//        validResponse ? print("valid", counter) : print("invalid")
        
        if validResponse {
            // Pass counter value here as total score for category.
            DBHelper.gymComplete = true
            self.navigationController?.pushViewController(categoriesBoard, animated: true)
        } else {
            print("invalid")
        }
    }
    
}
