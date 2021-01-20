//
//  HomeVc.swift
//  Crokitta
//
//  Created by deepo on 1/13/21.
//  Copyright © 2021 deepo. All rights reserved.
//

import UIKit
import Firebase

class HomeVc: UIViewController {
    
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateViews()
        
    }
    
    func UpdateViews()
    {
        underView.roundCorners([.topLeft,.topRight], radius: 40)
        signInButton.layer.cornerRadius = signInButton.frame.height/2
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
    }
    
    @IBAction func signInButton(_ sender: Any) {
           gotoViewController(ViewController: SignInVc())
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        gotoViewController(ViewController: SignUpVc())
    }
    
    
    
}
