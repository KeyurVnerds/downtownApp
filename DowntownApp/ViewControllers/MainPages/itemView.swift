//
//  itemView.swift
//
//
//  Created by Aaron Marsh on 5/18/20.
//

import UIKit
import Firebase
import FirebaseFunctions
import Kingfisher
import SafariServices
import Stripe
import Alamofire

var quanity: Int = 0
var imageList = [String]()
class itemView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate {
    @IBOutlet weak var imageCollection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCollection.contentSize = CGSize(width: 2, height: self.imageCollection.frame.height)
      return  imageList.count
    
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! viewProduct
          let url = imageList[indexPath.item]
        
        
      let imgUrl = URL(string: url)
        cell.image.kf.setImage(with: imgUrl )
      
//        cell.image.image = UIImage(named: "CAT02")
        
        cell.frame.size = CGSize(width: 355, height: 317)
        cell.image.contentMode = .scaleAspectFill
        
        return cell
        
    }
  public  let lineItems: [String: Any] = [:]
  
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var variationWheel: UIPickerView!
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var numberLabel: UILabel!
     var pickerData = [String]()
    @IBOutlet weak var smallImage1: UIImageView!
    @IBOutlet weak var smallImage2: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var popUp: UIView!
    
    @IBAction func bookMark(_ sender: Any) {
        save_Item(recordId: globalProductId, base: globalBase)
    }
    
    var paymentContext = STPPaymentContext()
    let customerContext = STPCustomerContext(keyProvider: MyAPIClient())

    
    
    func presentPopUpView () {
        var initLayer: UIView {
            let view = UIView()
          
            view.frame.size = popUp.frame.size
            
            return view
        }
   
        view.addSubview(initLayer)
        popUp.frame.origin = CGPoint(x: 700, y: self.view.frame.minY)
//        popUp.center = self.view.center
        popUp.layer.borderWidth = 1
        cardView.layer.borderWidth = 0.5
        popUp.layer.cornerRadius = 20
        cardView.layer.borderColor = UIColor.gray.cgColor
        
        view.addSubview(popUp)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerData.count
    }
    private var image_Urls = [String]()
    var imagesArray = [Any]()
    

    @IBOutlet weak var dropDown: UIPickerView!
    enum CardState {
          case expanded
          case collapsed
      }


      // The data to return for the row and component (column) that's being passed in

        
    
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
          return pickerData[row]
      }

      //Called when the user changes the selection...
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let  chosenState = pickerData[row]
         
         globalDetails = chosenState
      }

 

      var visualEffectView:UIVisualEffectView!
      
      let cardHeight:CGFloat = 600
      let cardHandleAreaHeight:CGFloat = 65
      
      var cardVisible = false
      var nextState:CardState {
          return cardVisible ? .collapsed : .expanded
      }
      
      var runningAnimations = [UIViewPropertyAnimator]()
      var animationProgressWhenInterrupted:CGFloat = 0
      
 
    func hideExtra (array: Array<String>) {
        
        smallImage2.isHidden = true
       
        let count = array.count
        
        
        
        switch count {
        case 1:
           print("1")
            
        case 2:
            smallImage1.isHidden = false
            
        default:
            print("default")
        }
    }
    @objc func smallImage01(_ sender: UITapGestureRecognizer) {
        print(sender)
        smallImage1.layer.borderWidth = 2
           print("It works from code too!")
       }
    @objc func smallImage02(_ sender: UITapGestureRecognizer) {
           print(sender)
              print("It works from code too!")
        smallImage2.layer.borderWidth = 2
          }
    
    func imageSetUp () {
//       let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(smallImage01(_:)))
//
//          // add your recognizer to your image
//         smallImage1.addGestureRecognizer(tapGestureRecognizer)
//
//          // enable user interactions or it won't work!
//        smallImage1.isUserInteractionEnabled = true
//        smallImage1.layer.cornerRadius = 32.5
//        smallImage1.layer.borderColor = UIColor.black.cgColor
//        smallImage1.layer.borderWidth = 1
//
//        smallImage2.isUserInteractionEnabled = true
//              smallImage2.layer.cornerRadius = 32.5
//              smallImage2.layer.borderColor = UIColor.black.cgColor
//              smallImage2.layer.borderWidth = 1
//         smallImage2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(smallImage02(_:))))
        
    }
    
         var image: UIImageView {
                let image = UIImageView()
    //            let image_url = URL(string: urlList[input])
                image.frame.size = CGSize(width: 60, height: 60)
          
                image.layer.cornerRadius = 30
                image.clipsToBounds = true
            
//            image.center.y = scroll.center.y
    //            image.kf.setImage(with: image_url)
            return image
            }
    
    @IBOutlet weak var smallImageScroll: UIScrollView!
    @IBOutlet weak var descriptionField: UITextView!
func small_Pic (numner: Int, scroll: UIScrollView, urlList: Array<String>) {
    func createIm (input: Int) -> UIImageView{
        var image: UIImageView {
            let image = UIImageView()
//            let image_url = URL(string: urlList[input])
            image.frame.size = CGSize(width: 100, height: 100)
            image.layer.cornerRadius = 7
            image.clipsToBounds = true
            image.backgroundColor = .black
//            image.kf.setImage(with: image_url)
        return image
        }
        smallImageScroll.addSubview(image)
        var locationCount = 0
//        for data in urlList {
            locationCount += 1
            
            createIm(input: 1)
            
//        }
        return image
    }
    
}
   
    @IBOutlet weak var holderView: UIView!
    private func scrollSetUp() {
        scroll.contentSize = CGSize(width: self.view.frame.width, height: 1500)
    }
    private func setProperties(){
        _ = [UIImage]()
        let Object = [
            "id": globalProductId,
            "base": globalBase
            
            
            
        ]
  
        
        functions.httpsCallable("moreInfo").call(Object) { (result, error) in
           if let error = error as NSError? {
             if error.domain == FunctionsErrorDomain {
                _ = FunctionsErrorCode(rawValue: error.code)
                _ = error.localizedDescription
                _ = error.userInfo[FunctionsErrorDetailsKey]
             }
             // ...
           }
            if let variations = (result?.data as? [String: Any])?["variations"]as? Array<String>{
                
                                variations.forEach { variety in
                                    self.pickerData.append(variety)
                                    print(variety)
                                }
                self.pickerView.reloadAllComponents()
                print(variations.count)
                
                
            }
            if let urls = (result?.data as? [String: Any])?["images"]as? Array<String>{
                for url in urls {
                    imageList.append(url)
                }
                print("###",imageList)
                self.imageCollection.reloadData()
                let description_Text = (result?.data as? [String: Any])?["description"]as? String
               
                self.descriptionField.text = nil
                self.descriptionField.text = description_Text
                let height = self.descriptionField.contentSize.height
                self.scroll.contentSize = CGSize(width: self.view.frame.width, height: 1600 + height)
                let hasNotch = increaseH()
                     if hasNotch == false {
                         print("No kkkkkkkkkk")
                         
                        self.scroll.contentSize = CGSize(width: self.scroll.frame.width, height: self.scroll.frame.height + height + 300)
//                        self.descriptionField.contentSize = CGSize(width: self.descriptionField.frame.width, height: self.descriptionField.frame.height + 200)
                     }
                print(description_Text!)
                self.descriptionField.isEditable = false
                self.image_Urls = urls
//                let image1 = self.small_Pic(numner: self.imagesArray.count, scroll: self.smallImageScroll, urlList: self.image_Urls) as! UIImageView
//                self.smallImageScroll.addSubview(image1)
                
                print(urls)
                var counter = -1
                    for word in urls {
                        print("count" , counter)
                            print(word)
                            let url = URL(string: word )
                            URLSession.shared.dataTask(with: url!) { data, response, error in
                                guard
                                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                                    let data = data, error == nil,
                                    let image = UIImage(data: data)
                                    else { return }
                                DispatchQueue.main.async() {
                                    self.imagesArray.append(image)
//                                   
//                                    self.productImageView.image = (self.imagesArray[0] as! UIImage)
//                                    self.smallImage1.image = (self.imagesArray[counter] as! UIImage)
//                                    self.hideViews()
                            }
                            }.resume()
                           
                  counter += 1
                        quanity = counter
                }
            }
     
                   
            
//            let description = (result?.data as? [String: Any])?["description"] as! String
//            print(description)
//
         

           
               
         }
        
        priceTag.text = "$" + globalProductPrice
        
        productName.text = globalProductName
        
        
        
        
        
    }

        var itemNumber = 10
    @IBAction func purchaseClicked(_ sender: Any) {
        
        print(globalDetails)
//        pay(productId: globalProductId, base: globalBase, qaunity: itemNumber)
      let urlString = "https://dtus.us/checkout?qaunity=\(1)&product=\(globalProductId)&uid=\(uid!)&detail=\(globalDetails)"
print(urlString, "#####")
      if let url = URL(string: urlString) {
        
          let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
          vc.delegate = self

          present(vc, animated: true)
      }

         
    }
    var imageIndex: Int = 0

    
    @IBAction func buttonTapped(_sender: UIButton) {
        
        if _sender == addButton {
        itemNumber += 1
            
        numberLabel.text = String(itemNumber)
            
        }
        else {
            if itemNumber > 1{
                itemNumber -= 1
                
                numberLabel.text = String(itemNumber)
            }
            
        }
    }
    @IBOutlet weak var smallTag: UILabel!
   
    @IBOutlet weak var priceTag: UILabel!
    
    func hideViews() {
        smallTag.isHidden = true
        
        priceTag.textColor = .black
        
        
        
    }
    func style (){
//        descriptionField.layer.borderWidth = 0.3
        brandLabel.layer.cornerRadius = 7
        brandLabel.clipsToBounds = true
        brandLabel.textColor = #colorLiteral(red: 0.9569, green: 0.7569, blue: 0.0941, alpha: 1)
        brandLabel.layer.borderWidth = 0.09
        brandLabel.layer.borderColor = UIColor.black.cgColor
//        productImageView.image = UIImage(named: "CAT01")
//        holderView.layer.cornerRadius = 15
//        holderView.layer.shadowOpacity = 0.5
//        holderView.layer.shadowOffset = .zero
//        holderView.layer.borderWidth = 0.2
    
    }
 
    func pickerViewCustomize () {
        let pv = pickerView
        pv?.layer.borderWidth = 2
        pv?.layer.cornerRadius = 5
    }
    @IBOutlet weak var purchaseButton: UIButton!
    @objc func showMiracle() {
           let slideVC = OverlayView()
           slideVC.modalPresentationStyle = .custom
           slideVC.transitioningDelegate = self
           self.present(slideVC, animated: true, completion: nil)
       }
    override func viewDidLoad() {
        UIApplication.shared.windows.forEach { window in
                  window.overrideUserInterfaceStyle = .light
              }
        imageList.removeAll()
       buttonSetup()
        let layout = imageCollection.collectionViewLayout as! UICollectionViewFlowLayout
                   layout.itemSize = CGSize(width: 355, height: 317)
        
        imageCollection.layer.shadowOffset = .zero
        imageCollection.layer.shadowOpacity = 0.5
        imageCollection.layer.cornerRadius = 10
        imageCollection.clipsToBounds = true
        itemNumber = 1
        style()
        scrollSetUp()
        imageSetUp()
        setProperties()
//        hideViews()
        pickerView.delegate = self
        pickerView.dataSource = self
         pickerViewCustomize()
        imageCollection.register(UINib(nibName:"viewProduct", bundle: nil), forCellWithReuseIdentifier: "image")
//        setupCard()
//        self.small_Pic(numner: self.imagesArray.count, scroll: self.smallImageScroll, urlList: self.image_Urls)
//        //                self.smallImageScroll.addSubview(image1)
//        smallImageScroll.addSubview(image)
//

        super.viewDidLoad()
        
        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
//        self.paymentContext.paymentAmount = 5000
        self.paymentContext.paymentCurrency = "USD"

        // Do any additional setup after loading the view.
         
//        pageControl.numberOfPages = imagesArray.count
//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(gesture:))) // put : at the end of method name
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        productImageView.isUserInteractionEnabled = true
//        self.productImageView.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(swiped(gesture:)))// put : at the end of method name
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.productImageView.addGestureRecognizer(swipeLeft)
//
    }
    @IBOutlet weak var purchase: UIButton!
    
    func buttonSetup() {
        purchase.layer.borderWidth = 3
        purchase.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func btnPurchaseAction(_ sender: UIButton) {
        guard !STPPaymentConfiguration.shared().publishableKey.isEmpty else {
            JSN.error("Please assign a value to `publishableKey` in StripeConstants.swift and make sure it is used to setup Stripe in AppDelegate.")
            return
        }


       if paymentContext.hostViewController == nil {
           paymentContext.hostViewController = self
       }
               // Present the Stripe payment methods view controller to enter payment details
        self.paymentContext.requestPayment() //presentPaymentOptionsViewController()
        
        showMiracle()

        
    }
    
    @IBAction func btnPaymentOptionAction(_ sender: UIButton) {
        self.paymentContext.pushPaymentOptionsViewController()
    }
    
    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right :
                print("User swiped right")
                
                // check if index is in range
                imageIndex = imageIndex - 1
                
                if imageIndex < 0 {
                    imageIndex = imagesArray.count-1
                }
            
                self.productImageView.image = (imagesArray[imageIndex] as! UIImage)
                
            case UISwipeGestureRecognizer.Direction.left:
                print("User swiped Left")
                
                // increase index first
                
                imageIndex = imageIndex + 1
                
                // check if index is in range
                
                if imageIndex >= imagesArray.count {
                    imageIndex = 0
                }
                
                self.productImageView.image = (imagesArray[imageIndex] as! UIImage)
                
            default:
                break //stops the code/codes nothing.
            }
            pageControl.currentPage = imageIndex
            
        }
    }
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK:- Payment context delegate
extension itemView: STPPaymentContextDelegate {
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        JSN.log("didFailToLoadWithError error ====>%@", error)
    }
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        JSN.log("paymentContext.selectedPaymentOption?.label ====>%@", paymentContext.selectedPaymentOption?.label as Any)
        JSN.log("paymentContext.selectedPaymentOption?.image ====>%@", paymentContext.selectedPaymentOption?.image as Any)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        JSN.log("payment response ====>%@", paymentResult.paymentMethodParams?.card as Any)
        
        var param = [String:Any]()
        param["amount"] = 5000
        param["currency"] = "USD"
        getStripeId { (stripeId) in
            param["customer"] = stripeId
            
            let header = ["Authorization":"Bearer " + seckretKey]
            let params = ["productId": globalProductId, "uid": uid!, "qaunity": 1,"detail":globalDetails] as [String : Any]
            Alamofire.request("https://downtown-proxy.herokuapp.com/postorder",method: .post, parameters: params,headers: header)
                .validate(contentType: ["application/x-www-form-urlencoded"])
                .responseJSON { (response) in
                    if let data = response.data {
                        let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??)
                        print(response.result.value)
                     
                    }else {
                        self.showAlert(title: "Alert", message: "Something went wrog")
                    }
                    
                }
        
        }}
    
    func paymentContext(_ paymentContext : STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        JSN.error("payment cotext delegate error ====>%@", error)
    }
    
    
    
    
}


extension itemView: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension itemView {
    public func alert(title: String, message: String){
        self.showAlert(title: title, message: message)
    }
 
}
