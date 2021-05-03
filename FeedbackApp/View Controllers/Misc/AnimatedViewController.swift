//
//  AnimatedViewController.swift
//  FeedbackApp
//
//  Created by Scott Benson on 4/30/21.
//

import UIKit

class AnimatedViewController: UIViewController {
    
    @IBOutlet weak var discountLabel: UIButton!
    @IBOutlet weak var beHeardLabel: UIButton!
    @IBOutlet weak var getRewardsLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    func animate() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.discountLabel.alpha = 0
            self.discountLabel.center.x -= 200
            
            self.beHeardLabel.alpha = 0
            self.beHeardLabel.center.x -= 200
            
            self.getRewardsLabel.alpha = 0
            self.getRewardsLabel.center.x -= 200
            
        }, completion: nil)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mainBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginBoard = mainBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(loginBoard, animated: true)
    }
    
}

