//
//  RefferedViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/9/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//
 
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFunctions
public var shopNameRefrence = ""
var categoryArray = ["Retro","Retro Tech", "Gaming","PC","Shoes","Foot Wear"]
var shopArray = [String] ()
class home: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    

      private  func fetchRequestsApi(completion: @escaping (_ models: [shopData]) -> Void ) {
    functions.httpsCallable("discoverShop").call(calledItem) { (item, error) in
               if let error = error as NSError? {
          
                 if error.domain == FunctionsErrorDomain {
                  _ = FunctionsErrorCode(rawValue: error.code)
                  _ = error.localizedDescription
                  _ = error.userInfo[FunctionsErrorDetailsKey]
                 }
                

                 // ...
               }
          if let res = (item?.data){
            
            print(res)
                   let data = res as! [[String: Any]]
            
            self.loader.isHidden = true
            print(data, "#####")
            var models = [shopData]()
                   for result in data {
                   let name = result["shopName"] as! String
                   let image = result["backGroundIm"] as! String
                   let location = result["location"] as! String
                   let shopName = result["shopName"] as! String
                    shopArray.append(shopName)
                    let description = ""
              
                    var array = Array<String>()
                    
                    array.append(image)
//                                array.forEach { word in
//                                    let url = URL(string: word )
//                                                                               let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                                                                 imageDataA.append(data as Any)
//
//
//
//
//
//
//                                                             }
                    let attribute = shopData(name: name, image: image, location: location, description: description)
//                                models.append(cellAttributes(name: name, image: image, price: price, isBookMarked:false))
                                                
//
                    
                    models.append(attribute)
                                            completion(models)
            }}}}



    
    class shopData {
            
        
            var image: String

            var name: String
            
            var description: String

            var location: String
            init(name: String, image: String, location:String , description: String) {
     self.name = name
     self.image = image
     self.location = location
    self.description = description

     }

        }

         
    
    
    
   private func scrollSetUp () {
    
        
    }
 
    @IBOutlet weak var notFoundLabel: UILabel!
    
    func searchShop () {
        shopNameRefrence = textfield.text!
        print("called")
        let searchObj = ["shopName": textfield.text!, "case": "check"]
        functions.httpsCallable("searchShop").call(searchObj) { (item, error) in
            if let error = error as NSError? {
                
                if error.domain == FunctionsErrorDomain {
                    _ = FunctionsErrorCode(rawValue: error.code)
                    _ = error.localizedDescription
                    _ = error.userInfo[FunctionsErrorDetailsKey]
                }
                
                
                // ...
            }
            if let res = (item?.data){
                
                ////            shopProductData = res as! [String : Any]
                print("res", res)
                self.loader.isHidden = true
                
                let exist = res as! Int
                
                if exist == 0 {
                    self.textfield.layer.borderColor = UIColor.red.cgColor
                    self.notFoundLabel.text = "Shop Couldn't Be Located."
                } else {
                    self.textfield.layer.borderColor = UIColor.black.cgColor
                    self.notFoundLabel.text = ""
                    self.performSegue(withIdentifier: "toShop", sender: self)
                }
                print(type(of: res))
                //
                //            let data = res as! [String: Any]
                //
                //            let response = data["response"] as! String
                //
                //            if response == "true" {
                
                
                //            }else {
                //
                //            }
                
                
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myData = data[indexPath.item]
        
        let cell = shopsCo.dequeueReusableCell(withReuseIdentifier: "shops", for: indexPath) as! discoveryCellCollectionViewCell
        cell.layoutIfNeeded()
        
//        cell.layer.borderWidth = 0.3
        
//        cell.about.text = myData.description
//
        cell.brandLogo.contentMode = .scaleAspectFit
        
        cell.brandLogo.contentMode = .scaleAspectFill
        
        cell.brandLogo.kf.setImage(with: URL(string: myData.image))
        
        cell.location.text = myData.location
        
        cell.brandName.text = myData.name
        
        cell.layer.shadowColor = UIColor.black.cgColor
         cell.layer.shadowOpacity = 1
         cell.layer.shadowOffset = .zero
         cell.layer.shadowRadius = 10
        cell.layer.borderWidth = 0.08
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowOffset = .zero
        cell.layer.cornerRadius = 30
        cell.layer.borderColor = UIColor.black.cgColor
//         cell.frame.size = CGSize(width: 375 , height: 680)
        cell.sizeToFit()
  
        cell.layoutIfNeeded()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.launchShop(_:)))

       cell.addGestureRecognizer(tap)

        return cell
    }
    @objc func launchShop (_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: self.shopsCo)
       let indexPath = self.shopsCo.indexPathForItem(at: location)
            if let index = indexPath {
                let currentShop = shopArray[index.row]

                shopNameRefrence = currentShop
                  print(shopNameRefrence)
                    self.performSegue(withIdentifier: "toShop", sender: self)
        }
       
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopsCo.contentSize = CGSize(width: self.view.frame.width, height: shopsCo.frame.height + CGFloat((data.count * 680)))
        return data.count
    }
    
    @IBOutlet weak var shopsCo: UICollectionView!
    
    
    @IBOutlet weak var collectionHolder: UIView!
    
    @IBOutlet weak var backDrop: UIImageView!
    
    
    
    func holderSetUP() {
        
        let holder = collectionHolder
        
        holder?.layer.cornerRadius = 25
    
        
    }
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var header: UILabel!
    private func customizeHeader () {
        
        header.text = "Discover"
//        let headerTitle = "Discover NEW Shops.".withBoldText(text: "NEW")
//        header.attributedText =  headerTitle
        
        header.font = UIFont(name: "Times", size: 40)
//
    }
    
    func collectionSetUp() {
        
        
        scroll.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
        let hasNotch = increaseH()
             if hasNotch == false {
                 print("No NOTCHHHHHHHHHHHHH")
                 
           
                     scroll.contentSize = CGSize(width: self.scroll.frame.width, height: self.scroll.frame.height + 300)
             }
        self.shopsCo.register(UINib(nibName:"discoveryCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shops")
   
        shopsCo.contentSize = CGSize(width: self.view.frame.width, height: 4700)

             let layout = shopsCo.collectionViewLayout as! UICollectionViewFlowLayout
             layout.itemSize = CGSize(width: 347, height: 153)
//         layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 100, right: 0)
//        shopsCo.frame.size = CGSize(width: self.view.frame.width, height: 2000)
        
    }
    func setbottomborder(uitextfeild:UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: uitextfeild.frame.height - 1, width: uitextfeild.frame.width, height: 2.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
        uitextfeild.borderStyle = UITextField.BorderStyle.none
        uitextfeild.layer.addSublayer(bottomLine)
    }
    
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var topBar: UIView!
    func setUp() {
        topBar.layer.shadowOpacity = 0.5
        topBar.clipsToBounds = true
        textfield.layer.cornerRadius = 10; textfield.clipsToBounds = true
    
        textfield.placeholder = "Search Shop Name"
        textfield.textAlignment = .center
        setbottomborder(uitextfeild: textfield)
        
        

        
        
        
    }
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tabBar: UITabBarItem!
    func tabBarSU() {
         UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Kefa", size: 15)!], for: .normal)
 
    }
    var  data: [shopData] = []
     
   
    override func viewDidLoad() {
        UIApplication.shared.windows.forEach { window in
                  window.overrideUserInterfaceStyle = .light
              }
        loader.startAnimating()
        notFoundLabel.text = nil
        textfield.delegate = self
        print("tf")
        collectionSetUp()

        tabBarSU()
        setUp()
        customizeHeader()
        super.viewDidLoad()
        fetchRequestsApi { models in
                   
            self.data = models
                   
                   self.shopsCo.reloadData()
                   
               
               
               // Do any additional setup after loading the view.
           }
        
        textfield.delegate = self
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
    
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    let bottomLine = CALayer()
          bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 2.0)
          UIView.animate(withDuration: 0.5) {
              bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
          }
          textField.borderStyle = UITextField.BorderStyle.none
          textField.layer.addSublayer(bottomLine)
          

               return true;
           }
          func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchShop()
            //delegate method
             textField.resignFirstResponder()
        
             return true
          }
}
extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = UIFont(name: "Bodoni 72 Oldstyle", size: 40)
    let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font as Any])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font!.pointSize)]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
}}


