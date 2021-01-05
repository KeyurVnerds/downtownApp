//
//  LoginViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/29/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var incorrectL: UILabel!
    
    func textFieldSetUp() {
        
     
        email.layer.cornerRadius = 7
        password.layer.cornerRadius = 7
        
        email.clipsToBounds = true
        password.clipsToBounds = true
    }
    func checkFields(){
        
        if email.text != "" && password.text != "" {
            
            
            
            checkLog.backgroundColor = .black
            checkLog.isUserInteractionEnabled = true
            
            
            
        }
        else {
            
            
            checkLog.backgroundColor = .gray
            checkLog.isUserInteractionEnabled = false
            
            
            
        }
        

        
        
        
        
    }
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func checkLog(_ sender: Any) {
        
        beginLoad()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)  { (User, Error)
                     in
            
            if Error != nil {
            //There has been an error.
                self.endLoad()
                self.incorrectL.text = "Your Email or Password was Incorrect"
                
                self.incorrectL.textColor = .red
                
            }
            else{
                initializeData()
//                self.performSegue(withIdentifier: "toPopular", sender: self)
                self.endLoad()
                self.performSegue(withIdentifier: "loggedIn", sender: self)
                self.incorrectL.text = ""
                
                
            }
            
        }
        
        
        
    }
    @IBOutlet weak var checkLog: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    func beginLoad () {
        
      
        UIView.animate(withDuration: 0.5) {
            self.scroll.alpha = 0.5
              self.ai.isHidden = false

        }
    }
    func endLoad () {
    UIView.animate(withDuration: 0.5) {
             self.scroll.alpha = 1
        self.ai.isHidden = true

         }
    
    }
    
    func resetBS () {
        
        
        
        resetButton.layer.borderWidth = 0.3
        
        
        
    }
    func setbottomborder(uitextfeild:UITextField){
           let bottomLine = CALayer()
           bottomLine.frame = CGRect(x: 0.0, y: uitextfeild.frame.height - 1, width: uitextfeild.frame.width, height: 2.0)
           bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
           uitextfeild.borderStyle = UITextField.BorderStyle.none
           uitextfeild.layer.addSublayer(bottomLine)
       }
       
    override func viewDidLoad() {

        setbottomborder(uitextfeild: email);
        setbottomborder(uitextfeild: password)
        UIApplication.shared.windows.forEach { window in
                   window.overrideUserInterfaceStyle = .light
               }
        textFieldSetUp()
        image.layer.cornerRadius = 20; image.clipsToBounds = true
        password.isSecureTextEntry = true
        checkFields()
        super.viewDidLoad()
resetBS()
        
        email.delegate = self
        password.delegate = self
        checkLog.layer.cornerRadius = (self.checkLog.frame.height) / 2
        ai.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 2.0)
        UIView.animate(withDuration: 0.5) {
            bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
        }
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        
    checkFields()
                return true;
            }
           func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
              textField.resignFirstResponder()
         
              return true
           }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(1)
        print("active")
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 2.0)
        textField.alpha = 0.2
        UIView.animate(withDuration: 0.5) {
            textField.alpha = 1
            bottomLine.backgroundColor = UIColor.black.cgColor
            
        }
        
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        return true;
    }
        
}
