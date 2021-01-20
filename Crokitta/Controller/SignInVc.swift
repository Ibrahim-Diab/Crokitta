//
//  SignInVc.swift
//  Crokitta
//
//  Created by deepo on 1/13/21.
//  Copyright © 2021 deepo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
class SignInVc: UIViewController,UITextFieldDelegate,GIDSignInDelegate {
   
    
    @IBOutlet weak var underview: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var Usernametxt: UITextField!
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var tapGoogle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
           }
        let loginButton = FBLoginButton()
        view.addSubview(loginButton)
        UpdateView()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        loginButton.permissions = ["public_profile", "email"]
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70 ).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
       // loginButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
       // loginButton.topAnchor.constraint(equalTo: tapGoogle.topAnchor, constant: 5).isActive = true
        // Do any additional setup after loading the view.
    }
    func UpdateView()
    {
        underview.roundCorners([.topRight,.topLeft], radius: 40)
        signInButton.layer.cornerRadius = signInButton.frame.height/2
        Usernametxt.borderStyle = .none
        Passwordtxt.borderStyle = .none
        addBottomLineToTextField(textField: Usernametxt)
        addBottomLineToTextField(textField: Passwordtxt)
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
           if let err = error
           {
               print(err.localizedDescription)
               
           }
       }
    func firebaselogin(credential:AuthCredential)
   {
   Auth.auth().signIn(with: credential) { (AuthDataResult, Error) in
   if  let err = Error
   {
   print(err.localizedDescription)
   }
   }
        }
    		
    @IBAction func signInButton(_ sender: Any) {
        guard let Email = Usernametxt.text else { return}
        guard let password = Passwordtxt.text else { return }
        Auth.auth().signIn(withEmail: Email, password: password) { (AuthDataResult, Error) in
            if let err  = Error
            {
                print(err.localizedDescription)
            }
            else
            {
                print("Success")
                self.gotoViewController(ViewController: HomeVc())
            }
        }
    }
    
    
    @IBAction func tapGoogle(_ sender: Any) {
         GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func GotoHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func GotoSignUP(_ sender: Any) {
         gotoViewController(ViewController: SignUpVc())
        
    }
    
    
}
