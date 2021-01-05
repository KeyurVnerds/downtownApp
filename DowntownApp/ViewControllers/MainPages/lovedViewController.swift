//
//  lovedViewController.swift
//
//
//  Created by Aaron Marsh on 10/4/20.
//

import UIKit
import FirebaseFunctions
class lovedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource {
  

       private var priceArray = [String]()
       private var imagesArray = [String]()
       private var nameArray = [String]()
       private var idArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           dataClass.count
       }
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var bannerUrl: String = ""
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

          
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liked", for: indexPath) as! SavedCell
           print(shopProductData)
           let data = dataClass[indexPath.item]
           imagesArray.append(data.image)
            nameArray.append(data.name)
            priceArray.append(data.price)
            idArray.append(data.id)
        
        collectionView.layer.shadowOpacity = 0.7
        collectionView.layer.shadowOffset = .zero
        
         
//           let data = shopProductData[indexPath.item]
//             cell.onBookMarkHandler = {
                    
//
//                    data.isBookMarked.toggle()
//
//                         self.collectionView.reloadItems(at: [indexPath])
//
//                }
//        data.isBookMarked = true
                //
//             if data.isBookMarked == true {
//                       print(true)
//                save_Item(recordId: idArray[indexPath.item], base: calledItem)
//                       cell.unsavedItem.image = UIImage(named: "saved")
//
//
//                   } else {
//
//
//                unSave_item(recordId: idArray[indexPath.item], base: calledItem)
//                          cell.unsavedItem.image = UIImage(named: "unsaved")
//
//                }
//
                   // self.shopCollectionView.reloadItems(at: [indexPath])
                   

                    cell.layoutIfNeeded()
        cell.frame.size = CGSize(width: self.view.frame.width - 50, height: 264)
        cell.image.contentMode = .scaleAspectFill
                        //or 160 width
                     
                        cell.layer.cornerRadius = 10
                cell.layer.borderWidth = 0.09
                        cell.layer.borderColor = UIColor.black.cgColor

                
                // BookMark Manipulation

            //    cell.bookMarkButton = data.isBookMarked
                
            //    cell.saveitem(QueryShopViewController())
                
//
//                cell.name.text = data.name
//                cell.price.text = "$" + data.price
                
                
            // Sets Them To Be Viewable//

               
                
                print(data.image)
            //    print(priceArray, "array")

                 cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))


   //
   //  print(data)
   ////
   //        print(data.name)
//           cell.name.text = data.name
           cell.image.kf.setImage(with: URL(string: data.image))
          
          


           return cell
       }
       @objc func tap(_ sender: UITapGestureRecognizer) {
         
//
//             let indexPath = self.tableView.indexPathForItem(at: location)
//             if let index = indexPath {
//
//
//               setItemProperties(name: nameArray[index.row], price: priceArray[index.row], id: idArray[index.row],base: calledItem)
//                print("Got clicked on index: \(index)!")
//       //        print("price", priceArray[indexPath!.row])
//
//               let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "itemView") as! itemView
//
//                let navigationVC = UINavigationController(rootViewController: secondVC)
//                self.present(navigationVC, animated: true, completion: nil)
//                performSegue(withIdentifier: "viewItem", sender: view)
//       //        performSegue(withIdentifier: "toItemViewer", sender: self)
//             }
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
            let searchObj = ["shopName": shopName, "case": "data"]
            print(uid!)
            functions.httpsCallable("clientSaved").call(["uid":uid!]) { (item, error) in
                        print("CALLLLLLLEDDDDD")
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
                                print(res)
//                                self.loader.startAnimating()
                                      let data = res as! [[String: Any]]
                               var models = [cellAttributes]()
                             
                       
                             
                                      for result in data {
                              
                                            let image = result["image"] as! String
                                          
                                          let name = result["name"] as! String
                                            let id = result["id"] as! String
                                              let price = result["price"] as! String
                                                          
                                   
                                
                                       var array = Array<String>()
                                       
                                       array.append(image)
       //
           
                                       
                                  let attribute = cellAttributes(name: name, image: image, price: price, isBookMarked:false, id: id)
                                                                   
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
              init(name: String, image: String, price:String , isBookMarked: Bool = true, id: String) {
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
           
           
           
       }
           
    func registerCell() {
           tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
       }
         
       var dataClass: [cellAttributes] = []
       var bannerLink: String = "https://ucarecdn.com/207e34d1-5154-47f8-bf29-fe026cc6eee1/detroit2361585_1920.jpg"
       
  
       override func viewDidLoad() {
//        loader.startAnimating()
        UIApplication.shared.windows.forEach { window in
                  window.overrideUserInterfaceStyle = .light
              }
registerCell()

           scrollSetUp()
         
     
              

           print(dataClass)
           
        tableView.reloadData()
           
           fetchRequestsApi{ models in
                  
                                  self.dataClass = models
                  
                                  self.tableView.reloadData()
                  
                  
                  
                              // Do any additional setup after loading the view.
                          }

           

           // Do any additional setup after loading the view.
       }
}
extension lovedViewController {
   

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
                return UITableViewCell()
            }
            let data = dataClass[indexPath.item]

            cell.productImage.kf.setImage(with: URL(string: data.image))
            cell.productName.text = data.name
            cell.companyName.text = ""
            cell.price.text = "$" + data.price
     
    //        cell.configureCellData(data: dataHandler[indexPath.item])
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              
            return dataClass.count
              
              
          }
          
        
    

}
