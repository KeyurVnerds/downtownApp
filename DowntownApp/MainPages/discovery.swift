//
//  refferedVcViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 1/13/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FirebaseFunctions
let grey = #colorLiteral(red: 0.9255, green: 0.9294, blue: 0.9176, alpha: 1)
var imageDataA = Array<Any>()
var imageUrls = Array<String>()
class refferedVcViewController: UIViewController{
 
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         
        let cell = topCollectionV.dequeueReusableCell(withReuseIdentifier: "buyCells", for: indexPath) as! inVentoryCell
        
 
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
 
    }
    @IBOutlet weak var productL: UILabel!
    func productLSetUP() {
          
        
 
          
          
      
          
          
      }
    @IBOutlet weak var menuBar: UIView!
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var priceViewer: UIView!
    
    func mirrorImage (yAxis: Int, stringInput: String) -> UIImageView {
                let height = testImage.frame.height
        let url = URL(fileURLWithPath: stringInput)
        let space = CGFloat(height * CGFloat(yAxis) )
        let image = UIImageView()
        image.frame.size = testImage.frame.size
        
 
        
//        let point = 700 + (height * CGFloat(yAxis))
//
        let x = testImage.frame.minX

        image.frame.size = testImage.frame.size
        
image.frame.origin = CGPoint(x: x , y:  space - 50)
        
        image.layer.borderWidth = 1
        image.backgroundColor = .gray
        
        image.layer.cornerRadius = 10
        
        image.clipsToBounds = true
        
            image.kf.setImage(with: URL(string: stringInput))
 
        
        scrollV.addSubview(image)
        
        
        return image
        
    }
        
    
    func viewSetUp() {
        
        testImage.image = nil
 
        functions.httpsCallable("discoveryPage").call("HeadPhones") { (items, error) in
                 if let error = error as NSError? {
                    print("Rannnnn")
                   if error.domain == FunctionsErrorDomain {
                    _ = FunctionsErrorCode(rawValue: error.code)
                    _ = error.localizedDescription
                    _ = error.userInfo[FunctionsErrorDetailsKey]
                   }
                   // ...
                 }
            
            if let itemss = (items?.data) {
                print(itemss, "hi")

        
print(images)
             
                               
                          let dataa = itemss as! Array<String>
                let url = URL(string: dataa[0])
      
                self.testImage.kf.setImage(with: url)

                self.mirrorImage(yAxis: 1, stringInput: dataa[1])
// 
                self.mirrorImage(yAxis: 2, stringInput:  dataa[0])
                self.mirrorImage(yAxis: 3, stringInput:  dataa[1])
                self.mirrorImage(yAxis: 4, stringInput:  dataa[0])
                self.mirrorImage(yAxis: 5, stringInput:  dataa[1])
                self.mirrorImage(yAxis: 6, stringInput:  dataa[0])
                
                          
             // access individual value in dictionary
         


 
}
}


        
        
    }
    
 
   
    @IBOutlet weak var herePage: UIImageView!
    @IBOutlet weak var toInfo: UIImageView!
    @IBOutlet weak var toHome: UIImageView!

       
    func setImages() {
        
//        let url = URL(string: "https://ucarecdn.com/b91cf69c-03ee-482b-b270-ae7665c6a47e/shinolaW.jpg")
//               testImage.contentMode = .scaleToFill
//          let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//               if Connectivity.isConnectedToInternet {
//                    print("Connected")
//                   testImage.image = UIImage(data: data!)
//                } else {
//                    print("No Internet")
//
//               }
        
           
        
        testImage.layer.cornerRadius = 10
        testImage.clipsToBounds = true
        
    }
    @IBOutlet weak var topCollectionV: UICollectionView!
    @IBOutlet weak var topCOllection: UICollectionView!
   
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    func topImagesSetUP(){
        
       var imageArray = Array<UIImageView>()
        imageArray = [image1,image2,image3]
        
        
        
        
        
    }

    @IBOutlet weak var scrollV: UIScrollView!
    func scrollView() {
        
        scrollV.contentSize = CGSize(width: self.view.frame.width, height: 10000)
            scrollV.isScrollEnabled = true
        
    }
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
        self.overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = .white
        super.viewDidLoad()
      
 

   setImages()
        productLSetUP()
        scrollView()
viewSetUp()
//       viewSetUp()
//
        // Do any additional setup after loading the view.
    }
    @objc func toInfoS(_ sender: UITapGestureRecognizer) {
          
          
       performSegue(withIdentifier: "toInfo", sender: self)
          print(2)
          }
    @objc func toHomeS(_ sender: UITapGestureRecognizer) {
          
          
       performSegue(withIdentifier: "toHome", sender: self)
          print(2)
        
        func trendingItemsViewSetUp(view: UIView, image: UIImageView, gestureRecog: UIGestureRecognizer) -> UIView {
            
            
            
            
            
            return view
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

}
