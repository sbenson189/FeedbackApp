//
//  DBController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/23/21.
//

import Foundation
import CoreData
import UIKit

class DBHelper {
    
    static var gymReviewScore = 0
    static var foodReviewScore = 0
    static var roomServiceReviewScore = 0
    static var poolAndSpaReviewScore = 0
    static var overallReviewScore = 0
    
    static var gymComplete = false
    static var foodComplete = false
    static var roomServiceComplete = false
    static var poolAndSpaComplete = false
    static var overallComplete = false

    static var inst = DBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addUserData (object : [String : String]) {
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context!) as! Users
        
        user.firstName = object["firstName"]
        user.lastName = object["lastName"]
        user.email = object["email"]
        user.phoneNumber = object["phoneNumber"]
        user.username = object["username"]
        user.password = object["password"]
        
        do {
            try context?.save()
            print("Data saved")
        } catch {
            print("Data was not saved")
        }
    }
    
    func addRoomReview(gymReviewScore : Int, foodReviewScore: Int, roomServiceReviewScore: Int, poolAndSpaReviewScore: Int, overallReviewScore: Int, room: Int) {
        var feedback = Feedback()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Feedback")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "roomNumber == %d", Int16(room))

        do {
            let feedbackFetch = try context?.fetch(fetchReq)

            if (feedbackFetch?.count != 0) {
                feedback = feedbackFetch?.first as! Feedback
                feedback.gym = Int16(gymReviewScore)
                feedback.attribute = Int16(foodReviewScore)
                feedback.roomService = Int16(roomServiceReviewScore)
                feedback.poolAndSpa = Int16(poolAndSpaReviewScore)
                feedback.overall = Int16(overallReviewScore)
                try context?.save()
                print("Feedback info updated")
            }
        } catch {
            print("Error while trying to update user info")
        }
    }
    
    func addUserCode(object : [String : String], code: String) {
        var user = Users()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)

        do {
            let userFetch = try context?.fetch(fetchReq)

            if (userFetch?.count != 0) {
                user = userFetch?.first as! Users
                user.code = code
                try context?.save()
                print("User info updated")
            }
        } catch {
            print("Error while trying to update user info")
        }
    }
    
    func addRoomForUser(object: [String : String], room: Int16) {
        var user = Users()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)

        do {
            let userFetch = try context?.fetch(fetchReq)

            if (userFetch?.count != 0) {
                user = userFetch?.first as! Users
                user.roomNumber = room
                try context?.save()
                print("User info updated")
            }

        } catch {
            print("Error while trying to update user info")
        }
    }
    
    func getUserRoomNumber(object: [String : String]) -> Int {
        var user = Users()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)
        
        do {
            let userFetch = try context?.fetch(fetchReq)

            if (userFetch?.count != 0) {
                user = userFetch?.first as! Users
            }
        } catch {
            print("Error while trying to update user info")
        }
        return Int(user.roomNumber)
    }
    
    func createRoomForFeedback (roomNumber: Int) {
        let feedback = NSEntityDescription.insertNewObject(forEntityName: "Feedback", into: context!) as! Feedback
        
        feedback.roomNumber = Int16(roomNumber)
        feedback.roomService = 0
        feedback.poolAndSpa = 0
        feedback.overall = 0
        feedback.attribute = 0
        feedback.gym = 0
        
        do {
            try context?.save()
            print("Data for room: \(roomNumber) saved")
        } catch {
            print("Data was not saved")
        }
    }
    
    func getUsers () -> [Users] {
        var user = [Users]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        do {
            user = try context?.fetch(fetchReq) as! [Users]
        } catch {
            print("Error fetching user data")
        }
        return user
    }
    
    static var found = 0
    
    func getSingleUser(username : String) -> Users {
        var user = Users()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        fetchReq.fetchLimit = 1
        do {
            let req = try context?.fetch(fetchReq) as! [Users]
            
            if req.count != 0 {
                user = req.first!
                DBHelper.found = 0
            } else {
                print("User not found helper")
                DBHelper.found = 1
            }
        } catch {
            print("Error while trying to retrieve user")
        }
        return user
    }
    
    func getFeedback () -> [Feedback] {
        var feedback = [Feedback]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Feedback")
        fetchReq.returnsObjectsAsFaults = false
        
        do {
            feedback = try context?.fetch(fetchReq) as! [Feedback]
        } catch {
            print("Error fetching user data")
        }
        return feedback
    }
    
    func updateUser (object: [String : String]) {
        var user = Users()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)
        
        do {
            let userFetch = try context?.fetch(fetchReq)
            
            if (userFetch?.count != 0) {
                user = userFetch?.first as! Users
                user.password = object["password"]
                try context?.save()
                print("User info updated")
            }
            
        } catch {
            print("Error while trying to update user info")
        }
        
    }
    
    public var currentUser = String()
    
    func deleteUser (username : String) {
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let user = try context?.fetch(fetchReq)
            context?.delete(user?.first as! Users)
            try context?.save()
        } catch {
            print("Error while trying to delete user")
        }
    }
    
    func getUserCode(username : String) -> String? {
        
        var user = Users()
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Users")
        fetchReq.returnsObjectsAsFaults = false
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        fetchReq.fetchLimit = 1
        do {
            let req = try context?.fetch(fetchReq) as! [Users]
            
            if req.count != 0 {
                user = req.first!
            } else {
                print("User not found")
            }
        } catch {
            print("Error while trying to retrieve user")
        }
        if user.code != nil {
            return user.code
        } else {
            return "No codes available"
        }
        
    }

}
