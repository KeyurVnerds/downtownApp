//
//  SignUpViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/28/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFunctions


class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var checkFields: UIButton!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickerView: UIPickerView!
    let pickerData = [ "AK - Alaska",
                       "AL - Alabama",
                       "AR - Arkansas",
                       "AS - American Samoa",
                       "AZ - Arizona",
                       "CA - California",
                       "CO - Colorado",
                       "CT - Connecticut",
                       "DC - District of Columbia",
                       "DE - Delaware",
                       "FL - Florida",
                       "GA - Georgia",
                       "GU - Guam",
                       "HI - Hawaii",
                       "IA - Iowa",
                       "ID - Idaho",
                       "IL - Illinois",
                       "IN - Indiana",
                       "KS - Kansas",
                       "KY - Kentucky",
                       "LA - Louisiana",
                       "MA - Massachusetts",
                       "MD - Maryland",
                       "ME - Maine",
                       "MI - Michigan",
                       "MN - Minnesota",
                       "MO - Missouri",
                       "MS - Mississippi",
                       "MT - Montana",
                       "NC - North Carolina",
                       "ND - North Dakota",
                       "NE - Nebraska",
                       "NH - New Hampshire",
                       "NJ - New Jersey",
                       "NM - New Mexico",
                       "NV - Nevada",
                       "NY - New York",
                       "OH - Ohio",
                       "OK - Oklahoma",
                       "OR - Oregon",
                       "PA - Pennsylvania",
                       "PR - Puerto Rico",
                       "RI - Rhode Island",
                       "SC - South Carolina",
                       "SD - South Dakota",
                       "TN - Tennessee",
                       "TX - Texas",
                       "UT - Utah",
                       "VA - Virginia",
                       "VI - Virgin Islands",
                       "VT - Vermont",
                       "WA - Washington",
                       "WI - Wisconsin",
                       "WV - West Virginia",
                       "WY - Wyoming"]
    
    
    private var selectedState: String = ""
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //Called when the user changes the selection...
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let  chosenState = pickerData[row]
        selectedState = chosenState
        print(chosenState)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    private func scrollSetUp () {
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 600)
        
    }
    func errorAlert (errorString: String) {
        let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    @IBOutlet weak var shippingLabel: UILabel!
    
    var uid = Auth.auth().currentUser?.uid
    
    func checkFieldsFunc() {
        if self.firstNameField.text != "" && self.lastNameField.text != "" && self.emailField.text != "" && self.passwordField.text != "" && self.cityField.text != "" && self.selectedState != "" && self.addressField.text != "" && self.zipcodeField.text != ""{
            checkFields.backgroundColor = .black
            checkFields.isUserInteractionEnabled = true
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (AuthDataResult, error) in
                if error != nil {
                    
                    self.errorAlert(errorString: error!.localizedDescription)
                    print(self.passwordField.text!)
                }
                if error == nil {
                    print("good signUp")
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (AuthDataResult, error) in
                        
                        if error == nil {
                            self.uid = Auth.auth().currentUser?.uid
                            print(self.uid)
                            
                            print("running")
                            
                            
                            let pageInfo = [
                                "uid": self.uid!,
                                "email": self.emailField.text!,
                                "firstName": self.firstNameField.text!,
                                "lastName": self.lastNameField.text!,
                                "password" : self.passwordField.text!,
                                "shipping": [
                                    "address" : self.addressField.text!,
                                    "city": self.cityField.text!,
                                    "zip": self.zipcodeField.text!,
                                    "state": self.selectedState
                                ]
                                
                                
                            ] as [String : Any]
                            
                            functions.httpsCallable("ClientSignUp").call(pageInfo) { (item, error) in
                                if let error = error as NSError? {
                                    
                                    if error.domain == FunctionsErrorDomain {
                                        _ = FunctionsErrorCode(rawValue: error.code)
                                        _ = error.localizedDescription
                                        _ = error.userInfo[FunctionsErrorDetailsKey]
                                    }
                                    
                                    
                                    // ...
                                }
                                if let res = (item?.data){
                                    if res as! String == "done" {
//                                        self.performSegue(withIdentifier: "beginSession", sender: self)
                                        self.performSegue(withIdentifier: "accountCreated", sender: self)
                                    } else {
                                        
                                    }
                                    print(res)
                                }}
                            
                            
                        } else {
                            print("error")
                            print(error)
                        }
                        
                        //                        }
                        
                    }
                    
                }
            }
        }
        
    }
    
    
    @IBOutlet weak var process: UIButton!
    
    private func layOut() {
        emailField.sizeToFit(); passwordField.sizeToFit()
        firstNameField.sizeToFit(); lastNameField.sizeToFit()
        cityField.sizeToFit(); addressField.sizeToFit()
        zipcodeField.sizeToFit(); pickerView.sizeToFit()
        
    }
    
    @IBAction func checkFieldsAction(_ sender: Any) {
        checkFieldsFunc()
        
    }
    
    
    override func viewDidLoad() {
        UIApplication.shared.windows.forEach { window in
                   window.overrideUserInterfaceStyle = .light
               }
        setbottomborder(uitextfeild: addressField)
        setbottomborder(uitextfeild: cityField)
        setbottomborder(uitextfeild: zipcodeField)
        setbottomborder(uitextfeild: passwordField)
        setbottomborder(uitextfeild: emailField)
        setbottomborder(uitextfeild: firstNameField)
        setbottomborder(uitextfeild: lastNameField)
        scrollSetUp()
        shippingLabel.attributedText = NSAttributedString(string: "Shipping", attributes:
                                                            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        //initialize Textfields
        checkFields.backgroundColor = .gray
        checkFields.isUserInteractionEnabled = false
        pickerView.delegate = self
        pickerView.dataSource = self
        
        lastNameField.delegate = self
        firstNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        cityField.delegate = self
        addressField.delegate = self
        zipcodeField.delegate = self
        
        //
        checkFields.layer.cornerRadius = 8
        
        super.viewDidLoad()
        
        
        //        process.backgroundColor = .gray
        //
        //        process.layer.cornerRadius = (self.process.frame.height) / 2
        //
        //
        //
        // Do any additional setup after loading the view.
    }
    private func textFieldBeginEndEditing(_ textField: UITextField) {
        
        
    }
    
    func setbottomborder(uitextfeild:UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: uitextfeild.frame.height - 1, width: uitextfeild.frame.width, height: 2.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
        uitextfeild.borderStyle = UITextField.BorderStyle.none
        uitextfeild.layer.addSublayer(bottomLine)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
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
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 2.0)
        UIView.animate(withDuration: 0.5) {
            bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
        }
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        
        //checkFieldsFunc()
        print(2)
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        checkFieldsFunc()
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    
    //
    //
    //
    //
    
    
    
    
}
