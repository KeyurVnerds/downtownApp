//
//  viewShopVc.swift
//  Downtown
//
//  Created by Aaron Marsh on 7/29/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseFunctions
class viewShopVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var priceArray = [String]()
    private var imagesArray = [String]()
    private var nameArray = [String]()
    private var idArray = [String]()
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopBanner: UIImageView!
    
    @IBOutlet weak var orderCountL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 0
    }
    var bannerUrl: String = ""
    
    func labelSetUp () {
        let text = "Products"
       let textRange = NSMakeRange(0, 8)
       let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
       // Add other attributes if needed
        productLabel.attributedText = attributedText
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               self.collectionView.register(UINib(nibName:"inVentoryCell", bundle: nil), forCellWithReuseIdentifier: "buyCells")
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buyCells", for: indexPath) as! inVentoryCell
        print(shopProductData)
        let data = dataClass[indexPath.item]
        imagesArray.append(data.image)
         nameArray.append(data.name)
         priceArray.append(data.price)
         idArray.append(data.id)
        print(idArray)
//        let data = shopProductData[indexPath.item]
          cell.onBookMarkHandler = {
                 
                 
                 data.isBookMarked.toggle()
                 
                      self.collectionView.reloadItems(at: [indexPath])
             
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


//
//  print(data)
////
//        print(data.name)
        cell.name.text = data.name
        cell.imageD.kf.setImage(with: URL(string: data.image))
       
       


        return cell
    }
    @objc func tap(_ sender: UITapGestureRecognizer) {
      
          let location = sender.location(in: self.collectionView)
          let indexPath = self.collectionView.indexPathForItem(at: location)
          if let index = indexPath {
            
            
            setItemProperties(name: nameArray[index.row], price: priceArray[index.row], id: idArray[index.row],base: calledItem)
             print("Got clicked on index: \(index)!")
    //        print("price", priceArray[indexPath!.row])

            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "itemView") as! itemView
            
             let navigationVC = UINavigationController(rootViewController: secondVC)
             self.present(navigationVC, animated: true, completion: nil)
             performSegue(withIdentifier: "viewItem", sender: view)
    //        performSegue(withIdentifier: "toItemViewer", sender: self)
          }
       }
    func imageSetUP() {
        shopBanner.layer.cornerRadius = shopBanner.frame.height / 2
        shopBanner.clipsToBounds = true
        
    }
    public class shopVcStruct {
            
        
            var image: String

            var name: String
            
            var price: String

            var id: String
            init(name: String, image: String, id:String, price: String) {
     self.name = name
     self.image = image
     self.id = id
    self.price = price

     }

        }

    
     

    @IBOutlet var image2: UIImageView!
    private var shopProductData: [shopVcStruct] = []
    func fetchRequestsApi(completion: @escaping (_ models: [cellAttributes]) -> Void ) {
        
        
        let shopName = shopNameRefrence
        let searchObj = ["shopName": shopName, "case": "view"]
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
                
                print(res)
                let data = res as! [String: Any]
                var models = [cellAttributes]()
                let rawData = [Any]()
                let background = data["logo"] as! String
                let orderCount = data["orders"] as! String
                
                print(orderCount)
                self.orderCountL.text = orderCount
                self.shopBanner.kf.setImage(with: URL(string: background))
                //                                   for result in rawData {
                //
                //                                   let image = result["image"] as! String
                //                                   let price = result["price"] as! String
                //                                   let id = result["id"] as! String
                //
                //
                //                                    self.shopNameLabel.text = "Fire Hoodies"
                //
                //                                    var array = Array<String>()
                //
                //                                    array.append(image)
                //    //
                //
                //
                //                               let attribute = cellAttributes(name: "Shop", image: image, price: price, isBookMarked:false, id: id)
                //
                //    //
                //
                //                                    models.append(attribute)
                //                                    completion(models)
                //
                //                            }
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

    @IBOutlet weak var contentScroll: UIScrollView!
    func scrollSetUp () {
        
        let scroll = contentScroll
        
        scroll?.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.width + shopBanner.frame.height + 400)
        
        
    }
        
        func collectionComfig() {
            let card = collectionView.layer
                 
                  

                  card.shadowOffset = CGSize(width: 0, height: 0)
                  
                  card.shadowColor = UIColor.black.cgColor
                  
                  card.shadowOpacity = 0.3
                  
                  card.cornerRadius = 20
//            collectionView.layer.borderWidth = 0.3

            let shopCollectionView = collectionView!
    //            shopCollectionView.isHidden = true
            collectionView.register(UINib(nibName:"inVentoryCell", bundle: nil), forCellWithReuseIdentifier: "buyCells")
     
    
                 shopCollectionView.setContentOffset(shopCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
            shopCollectionView.reloadItems(at: [])
           
    //        let width = (view.frame.size.width - 40) / 3
    //        let layout = shopCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //        layout.itemSize = CGSize(width: width, height: width )
    ////
    ////
    //
                   }
      
    var dataClass: [cellAttributes] = []
    var bannerLink: String = "https://ucarecdn.com/207e34d1-5154-47f8-bf29-fe026cc6eee1/detroit2361585_1920.jpg"
    
    func elementHide () {
        shopBanner.image = nil
        shopNameLabel.text = nil
    }
      
    override func viewDidLoad() {
        elementHide()
collectionComfig()
        scrollSetUp()
      
        labelSetUp()
           
        collectionView.delegate = self
        collectionView.dataSource = self
        print(dataClass)
        
        collectionView.reloadData()
        
        fetchRequestsApi{ models in
               
                               self.dataClass = models
               
                               self.collectionView.reloadData()
               
               
               
                           // Do any additional setup after loading the view.
                       }
        imageSetUP()
        

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
extension UIImageView {
    func downloadIm(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
 
}
