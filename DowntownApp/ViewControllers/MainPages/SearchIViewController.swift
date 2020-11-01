


import UIKit
 
import Firebase
import FirebaseDatabase
import FirebaseFunctions
            var y = 171
 

var bTabW = 1.0

var cellCount = 0
var senderS = "nil"
 var serverQ = ""
var serverS = false
let bg =  (red: 0.9686, green: 0.9686, blue: 0.9686, alpha: 1) /* #f7f7f7 */
class searchI: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var notFound: UILabel!
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var bagV: UIView!
    @IBOutlet weak var homeH: UIView!
    @IBOutlet weak var tabH: UIView!
    //
    
    
    
    
    func itemQuery(){
        
        
        
        
        functions.httpsCallable("addMessage").call(["text": searchBar.text]) { (result, error) in
          if let error = error as NSError? {
            if error.domain == FunctionsErrorDomain {
              let code = FunctionsErrorCode(rawValue: error.code)
              let message = error.localizedDescription
              let details = error.userInfo[FunctionsErrorDetailsKey]
            }
            // ...
          }
          if let text = (result?.data) {
            print(text)
          }
        }
        
        
        
    }

    
    func resetP(){
        
        
        
        
        
        
        
        
        
    }
    
    func serverQuery() {
        let query = self.searchBar.text!
    
    serverQ = query
        let ref = Database.database().reference()
      ref.child("Items").child("Category").child(serverQ).observeSingleEvent(of: .value) { (serverA) in
    
    print(serverA.value)
    if serverA.hasChildren(){
                self.notFound.text = "Sorry, Item Not Found"
        serverS = false
        
            }
            else{
                self.notFound.isHidden = false
                serverS = true
            }
        
            
        }
        
        
    }
    @IBOutlet weak var searchb: UIButton!
    
    let ref = Database.database().reference()
    
 
 
    
    
    
    
    
    @IBAction func searchB(_ sender: Any) {
        
        
     let query = self.searchBar.text!
        
        serverQuery()
        
        
        
    }
    
 
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchCo: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
        section: Int) -> Int {
 
 cellCount = 99999
      return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
             let cell = searchCo.dequeueReusableCell(withReuseIdentifier: "buyCells", for: indexPath) as! UICollectionViewCell
        
        
        
        cell.frame.size = CGSize(width: 200 - 40, height: 253)
        
        return cell
        
    }
    
 // Label Initialize
    
    @IBOutlet weak var mens: UILabel!
    @IBOutlet weak var furniture: UILabel!
    @IBOutlet weak var all: UILabel!
    @IBOutlet weak var tech: UILabel!
    @IBOutlet weak var womens: UILabel!
    
    
    
    
    
    
    //
 
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var mensDe: UIButton!
    @IBOutlet weak var furnitureDe: UIButton!
    @IBOutlet weak var allDe: UIButton!
    @IBOutlet weak var techDe: UIButton!
    @IBOutlet weak var womensDe: UIButton!
    @IBOutlet weak var uiSLider: UIView!
//    @IBOutlet var panS: UIPanGestureRecognizer!
    
 
    
    let uid = Auth.auth().currentUser?.uid
    // Retreives name
    
    
    let itemsR = Database.database().reference()
    
    
    @IBAction func panS(_ sender: Any) {
        
        UIView.animate(withDuration: 1/2, animations: {
            
            self.header.frame.origin = CGPoint(x: 0 , y: 0)
 
        })
        
    }
    
    
    //
    
    
  
    
       
//
//    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizer.Direction.right:
//                print("Swiped right")
//            case UISwipeGestureRecognizer.Direction.down:
//                print("Swiped down")
//            case UISwipeGestureRecognizer.Direction.left:
//                print("Swiped left")
//
//            default:
//                break
//            }
//        }
//
//
//    self.searchBar.isHidden = true
//
//    }
    //Func Array Begins
    
    
    
    
 
    
    
    
    
    
    
    
    
   
    
    override func viewDidLoad() {
        
        //set tBar//
         
         

        
//       var sizeO = (self.view.frame.width)/5
 
     
        
            
        
     
        
   
//        self.mens.frame.size = CGSize(width: sizeO, height: 200.00)
//        self.womens.frame.size = CGSize(width: sizeO, height: 200.00)
//        self.all.frame.size = CGSize(width: sizeO, height: 200.00)
//        self.tech.frame.size  = CGSize(width: sizeO, height: 200)
//        self.furniture.frame.size = CGSize(width: sizeO, height: 200.00)
//
         var sizeO = self.view.frame.width
                let furnitureX:CGFloat
        //        let sizeO = sizeO * 5
                     
                    //
                 let newS = (sizeO / 5)
                  furnitureX = newS - sizeO
        
 
        self.uiSLider.frame.origin = CGPoint(x: (self.view.frame.width)/2, y: CGFloat(y))
            
        
        
        self.tabH.frame.origin = CGPoint(x: 0, y: 140)
        
        
        if Auth.auth().currentUser != nil{
        // Gesture Tab R
        
            
            
        
// receipt()
        
        
        
//
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
//        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
//        self.view.addGestureRecognizer(swipeDown)
//
        
     // Config
        
        
    
        
        //
        // Icon 
        }
        
        
        
        //
        
        print(searchCo.frame.minX)
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        let ref = Database.database().reference()
    
        
        
//            let firstname = firstN.value as! String
//
//
//
//            print(firstname)
//
//
//            print("active!")
//            self.name.text = firstname
 
        
        
    
        //collection View Edits
        
        
        
        //Segue edit
        
        
        
        
        
        self.searchCo.register(UINib(nibName:"inVentoryCell", bundle: nil), forCellWithReuseIdentifier: "buyCells")
        
        self.searchCo.delegate = self
        self.searchCo.dataSource = self
        
        let width = (view.frame.size.width - 40) / 2
        
     
        //Extra spacing
        let space = (CGFloat(cellCount) / 2.0) * 1900.0
      
        print(space)
        searchCo.contentSize = CGSize(width: view.frame.width, height: searchCo.frame.height + space + 1000 )

                
                let layout = searchCo.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = CGSize(width: width, height: width )
        //
        
//        searchCo.frame.size = CGSize(width: searchCo.frame.width, height: searchCo.frame.height + space + 1000  )
//
        
        
       
        var mensX:CGFloat
//        var furnitureX: CGFloat
        
        var techX: CGFloat
        var womensX: CGFloat
        var allX: CGFloat
}
    
//    @IBAction func mensD(_ sender: Any) {
//
//
//           senderS = "mensD"
//
//
//
//
//           UIView.animate(withDuration: 1/2, animations: {
//
//               self.uiSLider.frame.origin = CGPoint(x: self.mensX, y: self.y)
//           })
//
//       }
//
//
//       @IBAction func furnitureD(_ sender: Any) {
//
//        var sizeO = self.view.frame.width
//        let furnitureX:CGFloat
////        let sizeO = sizeO * 5
//
//            //
//         let newS = (sizeO / 5)
//          furnitureX = newS - sizeO
//
//
//
//
//            senderS = "furnitureD"
//           UIView.animate(withDuration: 0.5, animations: {
//               // Do animation
//
//               self.uiSLider.frame.origin = CGPoint(x: furnitureX, y: 200)
//           })
//
//       }
//
//       @IBAction func allD(_ sender: Any) {
//
//
//            senderS = "allD"
//           UIView.animate(withDuration: 0.5, animations: {
//               // Do animation
//
//
//               self.uiSLider.frame.origin = CGPoint(x: allX, y: self.y)
//           })
//
//       }
//       @IBAction func techD(_ sender: Any) {
//           senderS = "techD"
//           UIView.animate(withDuration: 1/2, animations: {
//
//               self.uiSLider.frame.origin = CGPoint(x: self.techX, y: self.y)
//           })
//
//
//
//       }
//       @IBAction func womensD(_ sender: Any) {
//
//           senderS = "womensD"
//
//           UIView.animate(withDuration: 1/2, animations: {
//
//               self.uiSLider.frame.origin = CGPoint(x: self.womensX, y: self.y)
//           })
//
//
//       }
//
//
//
       
    
    
    
    
    
    
    
 
}

