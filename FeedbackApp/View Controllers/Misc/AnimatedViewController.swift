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
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView.backgroundColor = .red
        view.addSubview(myView)

    }

    
}
