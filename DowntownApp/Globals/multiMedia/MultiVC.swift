//
//  MultiVC.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/5/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//

import Foundation
import Firebase
import MapKit
import Lottie
import FirebaseAuth
import FirebaseDatabase
import SafariServices
import UIKit
 var categoryStatus = "Gaming"
 var ffirstName = ""
var llastName = ""
var uidd = ""
public var shopProductData = [Any]()
public let offWhite = #colorLiteral(red: 0.9608, green: 0.9647, blue: 0.9725, alpha: 1)
var queryCount: Int = 0

func initializeData () {
    print("Initialized Has Started")
uidd = uid!
    // firstname
    ref.child(uid!).child("firstName").observe( .value) { (firsnamee) in
        
        _ = firsnamee.value
//            ffirstName = firstN as! String
            print(ffirstName)
    }

    // Last Name
    ref.child(uid!).child("lastName").observe( .value) { (lastname) in
        
        let lastN = lastname.value
        
        if lastN != nil {
            
            
//           llastName = lastN as! String
            
            print(llastName)
            
        }
        else {
            
          return
            
        }
        
        
    }
}
    

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}




class hide{
    
    
    init(){
     
       
        
    }
    
    
    
    func viewType1 (viewInput: UIView) -> UIView{
        
        
        viewInput.layer.shadowOpacity = 0.5
        viewInput.layer.shadowColor = UIColor.black.cgColor
        viewInput.layer.borderWidth = 2
        
        
        return viewInput
        
        
    }
    func hidden (view: UIView)  -> UIView {
        
        
        view.isHidden = true
        return view
        
    }
    func unHide(view: UIView) -> UIView {
        
        
        view.isHidden = false
        
        return view
    }
}

func catButtons(button: UIButton) {
    button.layer.cornerRadius = 7
    button.clipsToBounds = true
    button.layer.borderWidth =  2
    button.layer.borderColor = UIColor.black.cgColor
    
    
}
// cat case funcs

func mens(image: UIImageView, sender: UIButton) {
    // CAT-01
    image.image = UIImage(named: "Mens")
    
}
func womens(image: UIImageView, sender: UIButton) {
    
    //CAT-02
    
    image.image = UIImage(named: "Mens")
    
}
func setCatIm (imageV: UIImageView,title: UILabel, input: String) {
    
    switch input {
    case "CAT-01":
        imageV.image = UIImage(named: "CAT01")
//           title.textColor = .gray
        title.text = "Mens Clothing"
    case "CAT-02":
//           title.textColor = .gray
        
        imageV.image = UIImage(named: "CAT02")
        title.text = "Womens Clothing"
    case "CAT-03":
        imageV.image = UIImage(named: "CAT03")
               title.text = "Home Decor"
//        title.textColor = .gray
  
        
    default:
        print("default")
    }
    
    
}
func get(url: String)-> Any{
    var object = [String: Any]()
    let semaphore = DispatchSemaphore (value: 0)

var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
  
    return
  }
    object["data"] = data
  print(String(data: data, encoding: .utf8)!)
  semaphore.signal()

}

task.resume()
semaphore.wait()
    return object
}

public func paymentCases(caseId: String) {
    
    switch caseId {
    case "1":
        print("God Attempt")
    case "4":
        print("bad charge")
    default:
        print("Wat")
    }
    
    

}
public func save_Item(recordId: String, base: String){

    print("invoked")
    let userIsIn = Auth.auth().currentUser
    if userIsIn != nil {
        let ref = Database.database().reference()
        ref.child(uid!).child("cartItems").child(recordId).setValue("\(base)_\(recordId)")
    }
    
}
public func unSave_item(recordId: String, base: String) {

    let ref = Database.database().reference()
 

    let directory = ref.child("uid").child("cartItems").child("\(base)_\(recordId)")

        directory.removeValue()
}

func logout() {
    
    
}
 
//public func loadingAni (view: UIView, holder: UIView) {
//    view.alpha = 0.3
//
//    let holderL = holder 
//
//        holderL.backgroundColor = .black 
//    
//    let layer = UIView()
//    let loadView: AnimationView
//    loadView = .init(name: "loading")
//     
//    loadView.frame.size = CGSize(width: 300, height: 300)
//    
////    loadView.frame.origin = CGPoint(x: view.frame.minX + 300, y: view.frame.minY)
//    
//    loadView.center = view.center
//    
//    loadView.sizeToFit()
//     
//     // 3. Set animation content mode
//     
//    loadView.contentMode = .scaleAspectFill
//     
//     // 4. Set animation loop mode
//     
//    loadView.loopMode = .loop
//     
//     // 5. Adjust animation speed
//     
//        loadView.animationSpeed = 0.7
//     
//     layer.addSubview(loadView)
//        
//        view.addSubview(layer)
//     
//     // 6. Play animation
//     
//    loadView.play()
//        if publicLoadBool == false {
//            loadView.pause()
//            layer.isHidden = true
//        }
//    
//}
func stopLoad (view: UIView) {
    
}

func launchPayment (id: String, qaunity: String) {

}


public extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
public func increaseH () -> Bool {
    if UIDevice.current.hasNotch {
        return true
        //... consider notch
    } else {
        
        return false
        //... don't have to consider notch
    }

}
