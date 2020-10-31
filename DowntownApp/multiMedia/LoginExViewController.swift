 //
 //  LoginViewController.swift
 //  Downtown
 //
 //  Created by Aaron Marsh on 4/11/19.
 //  Copyright © 2019 Zinc. All rights reserved.
 //
// var cream = #colorLiteral(red: 0.9686, green: 0.8941, blue: 0.6275, alpha: 1) /* #f7e4a0 */
//  var name = "aaron"
// /* #f7e4a0 */
//  
// var hi = "hey"
// let hie = name + hi
// var failedAttempt = 0
// @IBAction func incorrectL(_ sender: Any) {
//    @IBOutlet weak var emailField: UITextField!
//    @IBAction func emailField(_ sender: Any) {
//    }
//    @IBAction func emailField(_ sender: Any) {
//    }
// }
 // var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
// import UIKit
// import Firebase
// import FirebaseAuth
// class LoginViewController: UIViewController, UITextFieldDelegate {
//     @IBOutlet weak var emailField: UITextField!
//     @IBOutlet weak var passwordField: UITextField!
//     @IBOutlet weak var testung: UILabel!
//     @IBOutlet weak var loginPages: UIImageView!
//     @IBOutlet weak var check: UIButton!
//     @IBOutlet weak var register: UIButton!
//     @IBOutlet weak var blurView: UIVisualEffectView!
//     
//     //    @IBOutlet weak var emailField: UITextField!
// //    @IBOutlet weak var passwordField: UITextField!
// //    @IBOutlet weak var testung: UILabel!
// //    @IBOutlet weak var failedAttemptBlur: UIVisualEffectView!
// //
// //
// //    @IBOutlet weak var check: UIButton!
// //    @IBOutlet weak var loginPages: UIImageView!
// //    @IBOutlet weak var nameText: UITextField!
// //
//     @IBOutlet weak var emaillabel: UILabel!
//     
//     @IBOutlet weak var passwordLabel: UILabel!
//     
//     
//     
//     var resetView:UIView{
//         
//         let resetView = UIView()
//         
//         resetView.frame.origin = CGPoint(x: 37, y: 256)
//         resetView.frame.size = CGSize(width: 300, height: 200)
//         resetView.backgroundColor = .white
//         resetView.layer.cornerRadius = 30
//         
//         
//         return resetView
//     }
//     var resetButton:UIButton{
//         let resetButton = UIButton()
//         resetButton.frame.size = CGSize(width: 300, height: 100)
//         resetButton.backgroundColor = .black
//         resetButton.layer.cornerRadius = 20
//         resetButton.frame.origin = CGPoint(x: 37, y: 256)
//         return resetButton
//     }
//     
//     
//     
//     @IBAction func check(_ sender: Any) {
//         
//         if emailField.text == ""{
//             self.testung.text = "Please enter Text"
//         }
//         self.checkLogFunc()
//         
//     }
//     
//     
//     func checkLogFunc() {
//         
//         let a = [1,2,3,4,5,6,7,8,9]
//         
//         // Get the size of the array
//         
//         let size = a.count
//         print(size)
//
//         Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) {
//             (User, Error)
//             in
//             if Error != nil{
//                 print("error")
//                 self.testung.textColor = UIColor.red
//                 self.testung.text = "Try Again"
//                 failedAttempt += 1
//                 self.loginPages.image = UIImage(named: "Login4.0")
//                 
//                 
//                 
//                 self.emailField.text = ""
//                 self.passwordField.text = ""
//                 
//                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1
//                 ) {
//                     self.emailField.textColor = UIColor.white
//                 }
//                 
//                 
//                 self.emailField.frame.origin = CGPoint(x: 90, y: 391)
//                 
//                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  UIView.animate(withDuration: 0.25, animations: {
//                     
//                     self.emailField.frame.origin = CGPoint(x:42, y: 391)
//                 })
//                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
//                     {  UIView.animate(withDuration: 0.25, animations: {
//                         self.emailField.frame.origin = CGPoint(x:42, y: 391)
//                         
//                     })
//                         
//                         UIView.animate(withDuration: 0.25, animations: {
//                             self.emailField.frame.origin = CGPoint(x:0, y: 391)
//                             
//                         })
//                         
//                         
//                         self.emailField.frame.origin = CGPoint(x:42, y: 391)
//                         //Break
//                         
//                         self.passwordField.textColor = UIColor.red
//                         DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                             self.passwordField.text = ""
//                         }
//                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                             self.passwordField.textColor = UIColor.white
//                         }
//                         UIView.animate(withDuration: 0.25, animations: {
//                             
//                             self.passwordField.frame.origin = CGPoint(x: 90, y: 498)
//                         })
//                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  UIView.animate(withDuration: 0.25, animations: {
//                             
//                             self.passwordField.frame.origin = CGPoint(x:42, y: 498)
//                         })
//                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
//                             {  UIView.animate(withDuration: 0.25, animations: {
//                                 self.passwordField.frame.origin = CGPoint(x:49, y: 498)
//                                 
//                             })
//                                 
//                                 //Break@A
//                                 
//                                 UIView.animate(withDuration: 0.25, animations: {
//                                     self.loginPages.frame.origin = CGPoint(x:50, y: 0)
//                                     
//                                 })
//                                 
//                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                     UIView.animate(withDuration: 0.25, animations: {
//                                         
//                                         self.loginPages.frame.origin = CGPoint(x: 0, y: 0)
//                                     })
//                                     
//                                     
//                                     
//                                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                         UIView.animate(withDuration: 0.25, animations: {
//                                             
//                                             self.loginPages.frame.origin = CGPoint(x: -50, y:0)
//                                             
//                                         })
//                                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                             UIView.animate(withDuration: 0.25, animations: {
//                                                 
//                                                 self.loginPages.frame.origin = CGPoint(x: 0, y: 0)
//                                                 
//                                                 
//                                             })
//                                             
//                                             
//                                             
//                                          
//
//                                             
//                                             
//                                         }
//                                         
//                                         
//                                         
//                                         
//                                         
//                                         
//                                         if failedAttempt == 0{
//                                             
//                                         }
//                                         if failedAttempt == 4{
//                                             UIView.animate(withDuration: 1, animations: {
//                                                 self.resetView.frame.size = CGSize(width: 300, height: 100)
//                                                 
//                                             })
//                                             
//                                             self.blurView.isHidden = false
//                                             self.testung.text = ""
//                                            self.check.isEnabled = true
//                                             self.blurView.effect = blur
//                                             self.resetView.isHidden = false
//                                             failedAttempt = 0
//                                         }
//                                         
//                                     }
//                                 }
//                                 
//                                 
//                                 
//                                 
//                                 
//                                 
//                             }
//                             
//                             
//                             
//                         }
//                         
//                     }
//                 }
//                 
//             }
//             else{
//               
//              
//                 
//                 
//                 
//                 self.view.backgroundColor = .black
//                 self.loginPages.image = UIImage(named: "newLogo")
//                self.loginPages.backgroundColor = .white
//                self.view.backgroundColor = .white
//                
//                let widths = ((self.view.frame.width) / 2)  
//                let height = self.view.frame.height - (100)
//                
//                UIView.animate(withDuration: 2, animations: {
//                    self.loginPages.frame.origin = CGPoint(x: widths , y: height)
//                    self.loginPages.frame.size = CGSize(width: 100, height: 100)
//                    
//                })
//                 self.check.isHidden = true
//                 self.testung.text = ""
//                 self.emailField.text = ""
//                 self.passwordField.text = ""
//                  self.passwordLabel.isHidden = true
//                 self.register.isHidden = true
//                 self.emaillabel.isHidden = true
//                 self.passwordField.self.isHidden = true
//                 self.emailField.self.self.isHidden = true
//                 DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                     self.performSegue(withIdentifier: "test", sender: self)
//                     print("success")
//                 }
//             }//
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//         }
//         
//         
//     }//Function Closure
//     
//     
//     
//     @IBAction func checkLog(_ sender: Any) {
//         
//         checkLogFunc()
//         
//         
//     }
//     
//     
//     
//   
//     
//     
//   
//         
//         
//         
//         
//         
//         
//         
//     
//     
//     
//     
//     
//     
//     
//        
//     
//
//
//     
//     override func viewDidLoad() {
//         
//      //temporary
//  
//     
//         
//         func textFieldShouldReturn(_ textField: UITextField) -> Bool
//         {
//             textField.resignFirstResponder()
//             return true
//         }
//         
//         if passwordField.isEditing == true {
//             print("Gottcha")
//             loginPages.image = nil
//         }
//       
//         loginPages.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
////         self.emailField.text = "aaronmarsh755@gmail.com"
////
////         self.passwordField.text = "Buddy2004"
////                 checkLogFunc()
//         super.viewDidLoad()
//         
//         self.blurView.contentView.addSubview(resetView)
// self.resetView.addSubview(resetButton)
//         resetView.isHidden = true
//         blurView.isHidden = true
//        // Image constraints
// //        self.loginPages.translatesAutoresizingMaskIntoConstraints = false
// //        self.loginPages.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
// //         self.loginPages.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
// //
// //       self.loginPages.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
// //
// //        self.loginPages.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//         self.loginPages.frame.origin = CGPoint(x: 0, y: 0)
//       print(failedAttempt)
//
//         
//      
//         // Do any additional setup after loading theview.
//     
//     
//
//     /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destination.
//         // Pass the selected object to the new view controller.
//     }
//     */
//
//    emailField.delegate = self
//         passwordField.delegate = self
//
//
// }
//
//
//
//     
//     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//         textField.resignFirstResponder()
//         return true
//     }
//
//
// }
//
 
