//
//  SignUpVc.swift
//  Crokitta
//
//  Created by deepo on 1/13/21.
//  Copyright © 2021 deepo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class SignUpVc: UIViewController {
    
    @IBOutlet weak var SetImageButton: UIButton!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var EmailAdress: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var SignUp: UIButton!
    var imgurl  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateView()
        handlingKeyboardShowAndHiding()
   
    }
    
    
    @IBAction func SetImageButton(_ sender: Any) {
        let imagepicker  = UIImagePickerController()
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
    }
    
    @IBAction func GotoHome(_ sender: Any) {
        gotoViewController(ViewController: HomeVc())
    }
    
    @IBAction func SignUp(_ sender: Any) {	 
        
       guard let email = EmailAdress.text else {return}
        guard let password = PassWord.text else {return}
        guard let username = Username.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (AuthDataResult, Error) in
            if let err = Error
            {
                print(err.localizedDescription)
            }
            else
            {
                print("Success")
            }
            guard  let userid = AuthDataResult?.user.uid else {return}
            let Storageimage = Storage.storage().reference()
            let filename = NSUUID().uuidString
            guard let imagedata = self.SetImageButton.imageView?.image else{return}
            guard let uploadimage = imagedata.jpegData(compressionQuality: 0.3) else {return}
            
            Storageimage.child("Image profile").child(filename).putData(uploadimage, metadata: nil) { (StorageMetadata, Error) in
                if let err = Error
                {
                    print(err.localizedDescription)
                }
                else
                {
                    print("successful")
                }
                Storageimage.child("Image profile").child(filename).downloadURL { (url, err) in
                    if let url = url?.absoluteString
                    {
                        self.imgurl = url
                        print("imageurl \(self.imgurl)")
                        let dict = ["username":username,"image":self.imgurl]
                        Firestore.firestore().collection("Users").document(userid).setData(dict, merge: true)
                        
                    }
                    
                }
            }
            self.gotoViewController(ViewController: SignUpVc())
        }
    }
    
    @IBAction func GotoSignIn(_ sender: Any) {
        weak var pvc = self.presentingViewController
//        gotoViewController(ViewController: SignInVc())
        dismiss(animated: true) {
            pvc?.present(SignInVc(), animated: true, completion: nil)
        }
    }
   
    
}
extension SignUpVc:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalimage   =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        SetImageButton.setImage(originalimage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
}
