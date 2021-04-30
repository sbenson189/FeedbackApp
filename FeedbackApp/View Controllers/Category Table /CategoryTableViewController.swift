//
//  CategoryTableViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/19/21.
//

import UIKit

class CategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var categoryLabelText = ["Room Service", "Food", "Gym", "Pool and Spa", "Overall"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryLabelText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
        // give cell that was given identifier in SB to use it here. TableViewCell is the class given to that cell.
        
        cell.categoryLabel.text = categoryLabelText[indexPath.row]

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.item {
        case 0:
            print(indexPath.item)
            
            let roomServiceBoard = mainBoard.instantiateViewController(withIdentifier: "roomService") as! RoomServicePageViewController
            self.navigationController?.pushViewController(roomServiceBoard, animated: true)
            
        case 1:
            print(indexPath.item)
            
            let foodBoard = mainBoard.instantiateViewController(withIdentifier: "food") as! FoodPageViewController
            self.navigationController?.pushViewController(foodBoard, animated: true)
            
        case 2:
            print(indexPath.item)
            
            let gymBoard = mainBoard.instantiateViewController(withIdentifier: "gym") as! GymPageViewController
            self.navigationController?.pushViewController(gymBoard, animated: true)
            
        case 3:
            print(indexPath.item)
            
            let poolAndSpaBoard = mainBoard.instantiateViewController(withIdentifier: "poolAndSpa") as! PoolAndSpaPageViewController
            self.navigationController?.pushViewController(poolAndSpaBoard, animated: true)
            
        case 4:
            print(indexPath.item)
            
            let overallBoard = mainBoard.instantiateViewController(withIdentifier: "overall") as! OverallPageViewController
            self.navigationController?.pushViewController(overallBoard, animated: true)
            
        default:
            print("")
        }
        
    }

}
