//
//  UserDetailViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 12/14/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//
let selectedTag = UIColor(hue: 0.1278, saturation: 0, brightness: 0.84, alpha: 1.0)
 var publicLoadBool = true
import UIKit
 import MapKit
import Firebase
import FirebaseFunctions

 

 
class UserDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dataView1: UIView!
    var cellDataArray = [Any]()
    @IBOutlet weak var locationCard: UIView!
    @IBOutlet weak var paymentCard: UIView!
    @IBOutlet weak var purchasedCount: UILabel!
    @IBOutlet weak var bookmarkCount: UILabel!
    @IBOutlet weak var last4L: UILabel!

    @IBAction func bookMark(_ sender: Any) {
        print("clicked")
    }
    func setProperties (bookMarked: String, purchased: String,lat: Double, lng: Double, last_4: String, lastName: String, firstName: String) {
//        if last_4 == "no card" {
//            last4L.text = "Add Card"
//        } else {
//            last4L.text = "4242"
//        }
        bookmarkCount.text = "8"
        purchasedCount.text = "4"
//        firstNameL.text = firstName
//        lastNameL.text = lastName
        let coordinate =  CLLocationCoordinate2D(latitude: lat, longitude: lng)
        zoomAndCenter(on: coordinate, zoom: 0.009)

        
    }
    func cardSetUp () {
        func cardShadow (view: UIView) {
            let card = view.layer
           
            card.shadowRadius = 10

            card.shadowOffset = CGSize(width: 0, height: 4)
            
            card.shadowColor = UIColor.black.cgColor
            
            card.shadowOpacity = 0.3
            
            card.cornerRadius = 20
        }
        let card1 = paymentCard
        let card2 = locationCard
//        cardShadow(view: card1!); cardShadow(view: card2!)
        
        
    }
    func layOut () {
       dataView1.center = self.view.center
        dataView1.autoresizesSubviews =  true
        dataView1.sizeToFit()
        dataView1.frame.size = self.view.frame.size
        
        
    }
    private func dv1 () {
        
    let layer0 = dataView1.layer

        layer0.shadowRadius = 10

        layer0.shadowOffset = CGSize(width: 0, height: 4)
        
        layer0.shadowColor = UIColor.black.cgColor
        
        layer0.shadowOpacity = 0.3
        
        layer0.cornerRadius = 20

    }
    @IBOutlet weak var firstNameL: UILabel!
    @IBOutlet weak var contentScroll: UIScrollView!
    
    @IBOutlet weak var lastNameL: UILabel!
    @IBOutlet weak var locationDisplay: MKMapView!
    func mapSetUP (lat: String, lng: String){
        locationDisplay.layer.cornerRadius = 20; locationDisplay.clipsToBounds = true
    
        
    }
//    private func openMapForPlace(lat:Double , long:Double , placeName:String = ""){
//        let userCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
//              // Does not have to be userCenter, could replace latitude: and longitude: with any value you would like to center in on
//
//              let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180))
//
//              locationDisplay.setRegion(region, animated: true)
//    }
    func zoomAndCenter(on centerCoordinate: CLLocationCoordinate2D, zoom: Double) {
        var span: MKCoordinateSpan = locationDisplay.region.span
        span.latitudeDelta *= zoom
        span.longitudeDelta *= zoom
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
       locationDisplay.setRegion(region, animated: true)
    }
    
    func viewLoadUp() {
//  openMapForPlace(lat: 42.4375589, long: -83.13610559999999, placeName: "Home")
//        let coordinate = CLLocationCoordinate2D(latitude: 42.437560, longitude: -83.136090 )
       
    dv1()
        cardSetUp()
      let scroll = contentScroll!
               scroll.isScrollEnabled = true

               scroll.contentSize = CGSize(width: self.view.frame.width, height: scroll.frame.height + 200  )
     

               print("here")
               print((scroll.contentSize.height + scroll.frame.height))


    }
       class cellAttributes {
           

           var image: String

           var name: String
           
           var  id: String

           var price: String
           init(name: String, image: String, price:String , id: String) {
    self.name = name
    self.image = image
    self.price = price
     self.id = id
    }

       }
       
    
    @IBOutlet weak var purchasedCard: UIView!
    
    func purchasedSetUp () {
        
        let card = purchasedCard!
        
        card.layer.cornerRadius = 10
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func retrieveData(completion: @escaping (_ models: [cellAttributes]) -> Void ) {
        
        let object = ["uid": uid]
          functions.httpsCallable("customer_Profile").call(object) { (item, error) in
                                   if let error = error as NSError? {
                              
                                     if error.domain == FunctionsErrorDomain {
                                      _ = FunctionsErrorCode(rawValue: error.code)
                                      _ = error.localizedDescription
                                      _ = error.userInfo[FunctionsErrorDetailsKey]
                                     }
                                    
                    
                                     // ...
                                   }
                              if let res = (item?.data){
                     
                        var purchasedData = [Any]()
                        print(res)
                        var last4D = ""
                        var pCount = ""
                        var bCount  = ""
                        var loc_lat = 1.00
                        var loc_lng = 1.00
                        var lastName = ""
                         var firstName = ""
                        if let dictionary = res as? [String: Any] {
                        if let last4 = dictionary["last4"] as? String {
                            last4D = last4
                            print(last4)
                            // access individual value in dictionary
                            }
                            if let savedTotal = dictionary["savedCount"] as? Int {
                                bCount = String(savedTotal)
                                               print("this", savedTotal)
                                               // access individual value in dictionary
                                               }
                            if let purchasedTotal = dictionary["purchaseCount"] as? Int {
                                                                                pCount = String(purchasedTotal)
                                                                                print(purchasedTotal)
                                                                                // access individual value in dictionary
                                                                                }
                            if let location_lat = dictionary["lat"] as? Double {
                                                                                                                   loc_lat = location_lat
                                                                                                                   print(location_lat)
                                                                                                                   // access individual value in dictionary
                                                                                                                   }
                            if let location_lng = dictionary["location"] as? Double {
                                                                                                                   loc_lng = location_lng
                                                                                                                   print(location_lng)
                                                                                                                   // access individual value in dictionary
                                                                                                                   }
                            if let thisLastName = dictionary["lastName"] as? String {
                                                                                                                                            
                       lastName = thisLastName                      // access individual value in dictionary
                                                                                                                                            }
                            if let thisFirstName = dictionary["firstName"] as? String {
                                             firstName = thisFirstName
                                                                                                                                                                                  
                                                                 }
                        }
                          
                                
                                self.setProperties(bookMarked: bCount, purchased: pCount,lat: loc_lat, lng: loc_lng, last_4: last4D, lastName: lastName, firstName: firstName)
//                                let data = res as! [[String: Any]]
//                                var count = 0
//
//                                for item in data {
//                                   purchasedData =  item["bookMarked"] as! Array
//                                    print(purchasedData)
//                                }
                      
                        var models = [cellAttributes]()
//                                       for result in purchasedData {
////                                       let name = result["name"] as! String
////                                       let image = result["images"] as! String
////                                       let price = result["price"] as! String
////                                       let id = result["id"] as! String
//                                        let lng = result["lng"] as! String
//                                        let lat = result["lat"] as! String
//                                      let bookMarkCount = result["savedCount"] as! String
//                                        let purchasedCount = result["purchasedCount"] as! String
////                                        let last4 = result["last4"] as! String
//                                        let locationArray = [lat, lng]
//
//                                        self.setProperties(bookMarked: bookMarkCount, purchased: purchasedCount, geo: locationArray , last_4: last4)
//                                        var array = Array<String>()
//
//                                        array.append(image)
//        //
//        //
//                                        let attribute = cellAttributes(name: name, image: image, price: price, id: id)
//        //                                models.append(cellAttributes(name: name, image: image, price: price, isBookMarked:false))
//
//        //
//
//                                        models.append(attribute)
//                                        completion(models)
//
//                                }
                                }
                    }
 
    }
    
    var signoutButton: UIButton {
        
        let button = UIButton()
        
        button.frame.size = CGSize(width: self.view.frame.width, height: 300)
        
        button.backgroundColor = .black
        
//        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: <#T##CGFloat#>)
        
        return button
        
    }
    @IBAction func logout(_ sender: Any) {
        signout()
    }
    let backGroundColor = #colorLiteral(red: 0.8392, green: 0.8392, blue: 0.8392, alpha: 1)
    @IBOutlet weak var buttonHolder: UIView!
    
    @IBOutlet weak var info_View: UIView!
    func style (){
//        view.backgroundColor = backGroundColor
        

        
    }
    @IBAction func refresh(_ sender: Any) {
        
    }
    @IBOutlet weak var holder1: UIView!
    
    func signout () {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            performSegue(withIdentifier: "logout", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
 
    var dataHandler: [cellAttributes] = []
    override func viewDidLoad() {
        
    
        UIApplication.shared.windows.forEach { window in
                  window.overrideUserInterfaceStyle = .light
              }
//        last4L.text = "4242"
//
//         bookmarkCount.text = "14"
//         purchasedCount.text = "4"
//         firstNameL.text = "Aaron"
//         lastNameL.text = "Marsh"
        viewLoadUp()
        style()
        layOut()
        purchasedSetUp()
    
        retrieveData{ models in
  self.dataHandler = models
}
        
        super.viewDidLoad()
      let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
      tap.numberOfTapsRequired = 2
      view.addGestureRecognizer(tap)
    
    }
    

    @objc func doubleTapped() {
        retrieveData{ models in
                self.dataHandler = models
              }
        // do something here
    }
}
