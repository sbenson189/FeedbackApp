//
//  SplashScreenViewController.swift
//  Exercise
//
//  Created by Scott Benson on 5/3/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var top: UIView!
    @IBOutlet weak var bottom: UIView!
    @IBOutlet weak var left: UIView!
    @IBOutlet weak var right: UIView!
    @IBOutlet weak var tag: UILabel!
    static var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 2, delay: 0.0, options: [.autoreverse], animations: {
                self.top.center.y -= 200
                self.bottom.center.y += 200
                self.left.center.x -= 400
                self.right.center.x += 400
        }, completion: nil)
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: false)
    }

        @objc func nextScreen() {
            let mainBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginBoard = mainBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(loginBoard, animated: true)
        }
}
