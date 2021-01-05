//
//  QueryShopViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/13/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//
 

var calledItem:String = "Mug"
var shouldRefresh = 0
import UIKit
import Firebase
import FirebaseFunctions
import Kingfisher
import Firebase
import FirebaseAuth

@available(iOS 13.0, *)
class QueryShopViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    var resourceCount = 0
    
//    @IBOutlet weak var catLabel: UILabel!
//    @IBOutlet weak var categroySV: UIScrollView!
//    @IBOutlet weak var button3: UIButton!
//    @IBOutlet weak var button2: UIButton!
//    @IBOutlet weak var button1: UIButton!
    
    // MARK: Array Init
    @IBOutlet weak var searchField: UITextField!
    private var priceArray = [String]()
       private var imagesArray = [String]()
       private var nameArray = [String]()
       private var idArray = [String]()
    
    func setbottomborder(uitextfeild:UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: uitextfeild.frame.height - 1, width: uitextfeild.frame.width, height: 2.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)
        uitextfeild.borderStyle = UITextField.BorderStyle.none
        uitextfeild.layer.addSublayer(bottomLine)
    }
    func setTextfield () {
        searchField.delegate = self
       setbottomborder(uitextfeild: searchField)
    }
    
    func newCat()
    {
           fetchRequestsApi{ models in
        
                        self.nameData = models
        
                        self.shopCollectionView.reloadData()
        
        
        
                    // Do any additional setup after loading the view.
                }
        
    }
    func cases() {
        switch calledItem {
        case "CAT-01":
//
//            mens(image: categoryImage, sender: button1)
                  loadCollection()
                    newCat()
        case "CAT-02":
                    fetchRequestsApi{ models in
            
                            self.nameData = models
            
                            self.shopCollectionView.reloadData()
            
            
            
                        // Do any additional setup after loading the view.
                    }

//            womens(image: categoryImage, sender: button2)
                    newCat()
            self.shopCollectionView.reloadData()
            
        case "CAT-03":
            newCat()
            loadCollection()
            print("furniture")
            
        default:
            print("default")
        }
        
        
    }

   


    // MARK: Category Selector
    @IBAction func button1A(_ sender: Any) {
        calledItem = "CAT-01"
        cases()
//        setCatIm(imageV: categoryImage, title: catLabel, input: calledItem)
  
        
    }
    @IBAction func button2A(_ sender: Any) {
        calledItem = "CAT-02"
              cases()
//        setCatIm(imageV: categoryImage, title: catLabel, input: calledItem)
   
    }
    @IBAction func button3A(_ sender: Any) {
        
        calledItem = "CAT-03"
        cases()
//        setCatIm(imageV: categoryImage, title: catLabel, input: calledItem)
        print("called item", calledItem)
    }
    func categoryScrollSU() {
//
//        categroySV.contentSize = CGSize(width: 2000, height: categroySV.frame.height)
//
//        categroySV.showsHorizontalScrollIndicator = false
        
        
    }
    func buttonSetUp() {
//
//        catButtons(button: button1); catButtons(button: button2);catButtons(button: button3)
        
    }
    
    // Cat Buttons
    
    
    
    func specificCategory(id: String) {
     func category(completion: @escaping (_ models: [cellAttributes]) -> Void) {

        functions.httpsCallable("showProduct").call(searchField.text) { (item, error) in
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
        var models = [cellAttributes]()
               for result in data {
               let name = result["name"] as! String
               let image = result["Images"] as! String
               let price = result["price"] as! String
         
                var array = Array<String>()
                
                array.append(image)
//                                                             }
                let attribute = cellAttributes(name: name, image: image, price: price, id: id)
                models.append(attribute)
                                        completion(models)
        }
        }

}
        //ends
        

        
 

        shopCollectionView.reloadData()

}
         category { models in
                
                self.nameData = models
                
                self.shopCollectionView.reloadData()
                
            
            
            // Do any additional setup after loading the view.
        }

    }
        //MARK: Fetch
      
    func fetchRequestsApi(completion: @escaping (_ models: [cellAttributes]) -> Void ) {
                functions.httpsCallable("showProduct").call(calledItem) { (item, error) in
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
                        var models = [cellAttributes]()
                               for result in data {
                               let name = result["name"] as! String
                               let image = result["image"] as! String
                               let price = result["price"] as! String
                               let id = result["id"] as! String
                            
                         
                                var array = Array<String>()
                                
                                array.append(image)
//
//
                                let attribute = cellAttributes(name: name, image: image, price: price, id: id)
//                                models.append(cellAttributes(name: name, image: image, price: price, isBookMarked:false))
                                                            
//
                                
                                models.append(attribute)
                                completion(models)
                                
                        }
                        }
            }
        }


    class cellAttributes {
        
        var isBookMarked: Bool

        var image: String

        var name: String
        
        var  id: String

        var price: String
        init(name: String, image: String, price:String , isBookMarked: Bool = false, id: String) {
 self.name = name
 self.image = image
 self.price = price
 self.isBookMarked = isBookMarked
            self.id = id
 }

    }
    
    
    
    
    func collectionComfig() {
print("configggggggggghgggghgghghggggghgggr")
//            shopCollectionView.isHidden = true
        self.shopCollectionView.register(UINib(nibName:"inVentoryCell", bundle: nil), forCellWithReuseIdentifier: "buyCells")
 
        shopCollectionView.bottomAnchor.constraint(equalTo: self.scroll.bottomAnchor, constant: 0).isActive = true
             shopCollectionView.setContentOffset(shopCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        self.shopCollectionView?.reloadItems(at: [])
       
//        let width = (view.frame.size.width - 40) / 3
//        let layout = shopCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: width )
////
////
//
               }
  
    

    @IBOutlet weak var scroll: UIScrollView!
    
    func scrollSetUp() {
        scroll.isScrollEnabled = true

        scroll.contentSize = CGSize(width: self.view.frame.width, height: self.scroll.frame.height  )
        shopCollectionView.frame.size = CGSize(width: self.scroll.frame.width, height: self.scroll.frame.height)
        let hasNotch = increaseH()
        if hasNotch == false {
            print("No NOTCHHHHHHHHHHHHH")
            
      
                shopCollectionView.frame.size = CGSize(width: self.scroll.frame.width, height: self.scroll.frame.height + 300)
        }
//          scroll.contentSize = CGSize(width:view.frame.width, height: self.scroll.frame.height + 1000)
//
 
        print("here")
        print((scroll.contentSize.height + scroll.frame.height))
        
    }
    
    
    
    
// MARK: Cell INIT
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    

  
 shouldRefresh  += 1
    print(shouldRefresh)
    let data = nameData[indexPath.item]
      let url = URL(string: data.image)
    let cell = shopCollectionView.dequeueReusableCell(withReuseIdentifier: "buyCells", for: indexPath) as! inVentoryCell
                
                cell.activityIndi.isHidden = true
    imagesArray.append(data.image)
    nameArray.append(data.name)
    priceArray.append(data.price)
    idArray.append(data.id)
    print(imagesArray.count)

    // MARK: Hanler
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        print("\(indexPath)")
    }
    cell.onBookMarkHandler = {
        
        
        data.isBookMarked.toggle()
        
             self.shopCollectionView.reloadItems(at: [indexPath])
    
    }
    //
 if data.isBookMarked == true {
           print(true)
    save_Item(recordId: idArray[indexPath.item], base: calledItem)
           cell.unsavedItem.image = UIImage(named: "saved")
    
          
       } else {


    unSave_item(recordId: idArray[indexPath.item], base: calledItem)
              cell.unsavedItem.image = UIImage(named: "unsaved")

    }
    
       // self.shopCollectionView.reloadItems(at: [indexPath])
       

        cell.layoutIfNeeded()
            cell.frame.size = CGSize(width: 160 , height: 264)
            
            //or 160 width
            cell.imageD.kf.setImage(with: url)
            cell.layer.cornerRadius = 10
    cell.layer.borderWidth = 0.09
            cell.layer.borderColor = UIColor.black.cgColor

    
    // BookMark Manipulation

//    cell.bookMarkButton = data.isBookMarked
    
//    cell.saveitem(QueryShopViewController())
    
    
    cell.name.text = data.name
    cell.price.text = "$" + data.price
    
    
// Sets Them To Be Viewable//

   
    
    print(data.image)
//    print(priceArray, "array")

     cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))

    return cell
}
    


    //
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    cellCount = prices.count
    return nameData.count
}



var backgroundGesture: UIView{
    
    
    let backgroundGesture = UIView()
    backgroundGesture.backgroundColor = .clear
    
     
    
    self.view.addSubview(backgroundGesture)
    return backgroundGesture
}






    









    @IBOutlet weak var shopCollectionView: UICollectionView!
    

 










//MARK: Tap
@objc func tap(_ sender: UITapGestureRecognizer) {
  
      let location = sender.location(in: self.shopCollectionView)
      let indexPath = self.shopCollectionView.indexPathForItem(at: location)
      if let index = indexPath {
        
        
        setItemProperties(name: nameArray[index.row], price: priceArray[index.row], id: idArray[index.row],base: calledItem)
         print("Got clicked on index: \(index)!")
//        print("price", priceArray[indexPath!.row])

        print(nameArray[index.row])
        print(priceArray[index.row])
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "itemView") as! itemView
        
         let navigationVC = UINavigationController(rootViewController: secondVC)
         self.present(navigationVC, animated: true, completion: nil)
         performSegue(withIdentifier: "viewItem", sender: view)
//        performSegue(withIdentifier: "toItemViewer", sender: self)
      }
   }
@IBOutlet weak var searchHolder: UIView!










@IBOutlet weak var label: UILabel!


@IBOutlet weak var searchBar: UITextField!
 lazy var functions = Functions.functions()
func itemQuery(){
    
    
    

    
    
}



@IBOutlet weak var userInfoB: UIImageView!

@IBOutlet weak var menuBarView: UIView!




 
    var  nameData: [cellAttributes] = []
//
//    @IBOutlet weak var categoryImage: UIImageView!
    override func viewDidLoad(){

    
//        categoryImage.image = UIImage(named: "CAT-1")
//    catLabel.text = "Mens Clothing"
    categoryScrollSU()
    setTextfield()
       super.viewDidLoad()
    buttonSetUp()
    itemQuery()
//        shopCollectionView.reloadInputViews()
//        shopCollectionView.setNeedsDisplay()
    
    //
    
    

    //
   
    
    
     
    if Auth.auth().currentUser == nil {
        print("wjej")
    }
    else {
    print(uid!)
    }
    view.backgroundColor = .white
    shopCollectionView.backgroundColor = .white
    
   
    
    shopCollectionView.delegate = self
    shopCollectionView.dataSource = self
       self.shopCollectionView.register(UINib(nibName:"buyCells", bundle: nil), forCellWithReuseIdentifier: "inventiryCell")

       let space = (CGFloat(cellCount) / 2.0) * 1900.0
            print(space)
            shopCollectionView.contentSize = CGSize(width: view.frame.width, height: shopCollectionView.frame.height + space + 1000 )

//
            let width = (view.frame.size.width - 20) / 3
            let layout = shopCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: 600 )
    
    
    

    
    //
//        //
 
  
   
    
    
 
            
   
    collectionComfig()
 
    
itemQuery()

scrollSetUp()
    
//        categoryImage.image = UIImage(named: "CAT01")
    
 loadCollection()
    let hasNotch = increaseH()
    if hasNotch == false {
        print("No NOTCHHHHHHHHHHHHH")
        
        shopCollectionView.contentSize = CGSize(width: self.shopCollectionView.frame.width, height: self.shopCollectionView.frame.height + 400 )
        
    }
    scroll.contentSize = CGSize(width:view.frame.width, height: self.scroll.frame.height + 1000)
  
    }
    func loadCollection() {
          fetchRequestsApi { models in
            self.imagesArray.removeAll()
            self.nameArray.removeAll()
            self.priceArray.removeAll()
            self.idArray.removeAll()
            
                self.nameData = models
                
                self.shopCollectionView.reloadData()
                
            
            
            // Do any additional setup after loading the view.
        }
    }

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/







@IBOutlet weak var menuBar: UIVisualEffectView!












@IBAction func signOut(_ sender: Any) {
    
    
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        performSegue(withIdentifier: "signOut", sender: self)
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
}






}


extension QueryShopViewController
{
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
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        calledItem = searchField.text!
           fetchRequestsApi{ models in
        
                        self.nameData = models
        
                        self.shopCollectionView.reloadData()
        
        
        
                    // Do any additional setup after loading the view.
                }
        textField.resignFirstResponder()
        print("return")

        return true
    }
}
