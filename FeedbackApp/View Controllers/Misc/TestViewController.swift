//
//  TestViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 5/5/21.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    static var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2, delay: 0.0, options: [.repeat, .autoreverse,], animations: {
            self.view1.transform = CGAffineTransform(rotationAngle: 360)
        }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0.3, usingSpringWithDamping: 3.0, initialSpringVelocity: 0, options: [.autoreverse, .repeat], animations: {
            self.view1.transform = CGAffineTransform(rotationAngle: 360)
        }, completion: nil)

        view1.layer.masksToBounds = true
        view1.layer.cornerRadius = view1.bounds.width / 2
        
        view2.layer.masksToBounds = true
        view2.layer.cornerRadius = view2.bounds.width / 2
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: false)
    }
    
    @objc func nextScreen() {
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginBoard = mainBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(loginBoard, animated: true)
    }
}
