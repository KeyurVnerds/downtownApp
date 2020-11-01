//
//  ResetPasswordViewController.swift
//  FirebaseAuth
//
//  Created by Aaron Marsh on 2/3/20.
//

import UIKit
import Firebase
import FirebaseAuth
class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resetB: UIButton!
    
    func resetBS () {
        
        
        resetB.layer.cornerRadius = 25
        
    }
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func checkAndSend(_ sender: Any) {
        
        cAndS()
    }
    @IBOutlet weak var exampleL: UITextView!
    func exampleS () {
        
        
        exampleL.isUserInteractionEnabled = false
        
        
    }
    @IBOutlet weak var resultsL: UILabel!
    
    override func viewDidLoad() {

        emailField.delegate = self
        
        exampleS()
    resetBS()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func cAndS () {
        
        if emailField.text != nil {
            
           //does contain so compare
            
            let privEmail = emailField.text!
            
            Auth.auth().fetchSignInMethods(forEmail: privEmail, completion: {
                (providers, error) in

                if let error = error {
                    print(error.localizedDescription)
                    print("error occured")
                    self.resultsL.text = "Sorry, this email doesn't exist."
                } else if let providers = providers {
                    
                    self.resultsL.text = "Loading..."
                  
                    self.resultsL.text = "Your email has sucessfully been delivred!"
                    
                    Auth.auth().sendPasswordReset(withEmail: privEmail) { error in
                        
                        if error != nil {
                        self.resultsL.text = "Something went wrong, please try again."
                        }
                    }
                    // pass email send
                    
                    
                    print(providers)
                }
            })

            
        }
        
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
          textField.resignFirstResponder()
     
   
           
           
           
          return true
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
