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
        
        email.layer.borderWidth = 3; password.layer.borderWidth = 3
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
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)  { (User, Error)
                     in
            
            if Error != nil {
            //There has been an error.
                
                self.incorrectL.text = "Your Email or Password was Incorrect"
                
                self.incorrectL.textColor = .red
                
            }
            else{
                initializeData()
                self.performSegue(withIdentifier: "toPopular", sender: self)
                self.incorrectL.text = ""
                
                
            }
            
        }
        
        
        
    }
    @IBOutlet weak var checkLog: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    func resetBS () {
        
        
        resetButton.layer.borderWidth = 0.3
        
        
        
    }
    override func viewDidLoad() {
        textFieldSetUp()
        image.layer.cornerRadius = 20; image.clipsToBounds = true
        password.isSecureTextEntry = true
        checkFields()
        super.viewDidLoad()
resetBS()
        
        email.delegate = self
        password.delegate = self
        checkLog.layer.cornerRadius = (self.checkLog.frame.height) / 2
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
     
    checkFields()
                return true;
            }
           func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
              textField.resignFirstResponder()
         
              return true
           }
        
}
