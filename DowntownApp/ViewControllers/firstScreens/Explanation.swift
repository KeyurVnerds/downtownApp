//
//  Explanation.swift
//  Downtown
//
//  Created by Aaron Marsh on 3/4/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import UIKit
var labelCount = Array<Int>()
var labels = Array<String>()
var intt = 0
var signUpBoolean = false
 
class Explanation: UIViewController {
    @IBOutlet weak var flashE: UILabel!
    @IBOutlet weak var backB: UIButton!
    
    @IBOutlet weak var nextB: UIButton!
    func custom() {
        nextB.backgroundColor = .white
        nextB.layer.borderWidth = 3
       backB.backgroundColor = .white
    backB.layer.borderWidth = 3
        backB.layer.cornerRadius = 7
             nextB.layer.cornerRadius = 7
        backB.clipsToBounds = true
        nextB.clipsToBounds = true
        
       flashE.font = UIFont(name: "Rockwell-Bold", size: 25)
        secondaryT.font = UIFont(name: "Rockwell-Bold", size: 35)
        secondaryT.isEditable = false
        secondaryT.layer.shadowOpacity = 1
        secondaryT.clipsToBounds = true
        dollarL.font =  UIFont(name: "Rockwell-Bold", size: 55)
            dollarL.textAlignment = .center
            dollarL.text = "$4.99"
        dollarL.isHidden = true
        }
    
    @IBAction func up(_ sender: Any) {
        goUp()
        
        if signUpBoolean == true {
            
            self.performSegue(withIdentifier: "signUp", sender: self)
            
            
        }
       
    }
    @IBOutlet weak var dollarL: UILabel!
    @IBAction func down(_ sender: Any) {
        goDown()
        if intt >= 0 {
                    setLabel()
            if intt == 2 {
                
                dollarL.isHidden = false
                dollarL.font = UIFont(name: "Rockwell-Bold", size: 25)
                secondaryT.font = UIFont(name: "Rockwell-Bold", size: 30)
            }
            else {
                dollarL.isHidden = true
                    secondaryT.font = UIFont(name: "Rockwell-Bold", size: 35)
            }
        }
 print(intt)
    }
    func goUp () {
 
          
                       if intt <= 10 {
                                   setLabel()
                   }
                 if intt == 2 {
                     
                            nextB.setTitle("Sign Up", for: .normal)
                     
                        signUpBoolean = true
                 }
                 else {
                    signUpBoolean = false
        }
                 if intt == 1 {
                     print("yesss")
                       dollarL.isHidden = false
                                   dollarL.font = UIFont(name: "Rockwell-Bold", size: 30)
                                   secondaryT.font = UIFont(name: "Rockwell-Bold", size: 28)
                           nextB.setTitle("Sign Up", for: .normal)

                 }
     
        
                 else {   nextB.setTitle("Next", for: .normal)

                     dollarL.isHidden = true
                         secondaryT.font = UIFont(name: "Rockwell-Bold", size: 35)
                 }
          print(intt)
    if intt < 5 {
        if intt <= 1 {
intt += 1
        }
    }
    else {
            
            print("to great")
        }
    }
    func goDown() {
        if intt == 0 {
          print("cant any more")
        }
        else {
      intt -= 1
    
        }
        
    }
    func setLabel()  {
        
        UIView.animate(withDuration: 1) {
            self.secondaryT.alpha = 0
            self.dollarL.alpha = 0
        }
        delay(0.1){
            self.secondaryT.text = labels[intt]
        }
        delay(0.9) {
            
        }
        UIView.animate(withDuration: 1) {
            self.dollarL.alpha = 1
        self.secondaryT.alpha = 1
        }
        
    }
    
    @IBOutlet weak var secondaryT: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // set array
        
        labels = ["Downtown is a Market Place built for small brands!", "Shop Businesses That Sell Perfume To Records", "Join The Downtown Premium Club for $4.99 Monthly!"]
custom()
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

}
