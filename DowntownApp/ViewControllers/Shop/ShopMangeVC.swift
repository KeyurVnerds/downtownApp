//
//  ShopMangeVC.swift
//  DowntownApp
//
//  Created by keyur on 09/01/21.
//  Copyright © 2021 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFunctions
import Lottie
import Stripe
import Alamofire


class ShopMangeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblOrder: UILabel!
    
    @IBOutlet weak var lottieContainer: UIView!
    @IBOutlet weak var view3: UIControl!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var orderTableView: UITableView!{
        didSet {
            orderTableView.register(UINib(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
        }
    }
    
    @objc func restartAnimation(bubblesView: AnimationView) {
           bubblesView.play()
    }
    @IBOutlet weak var lblProfit: UILabel!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    var order:NSArray = []

   private func addAnimation() {


    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    func addReconizer () {
  
          let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(addUserInfo(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(addUserInfo(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.scroll.addGestureRecognizer(leftSwipe)
         self.scroll.addGestureRecognizer(rightSwipe)
    }
    
    var bubblesView:AnimationView = AnimationView()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//         let bubblesView: AnimationView
      
        bubblesView = .init(name: "blobs")
     bubblesView.frame.size = view1.frame.size
     bubblesView.contentMode = .scaleAspectFill
        
        // 4. Set animation loop mode
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: Notification.Name.NSExtensionHostDidEnterBackground, object: nil)
        bubblesView.loopMode = .loop
        
        // 5. Adjust animation speed
        
        bubblesView.animationSpeed = 0.7
     
     bubblesView.play()
        
        lottieContainer.addSubview(bubblesView)
  
        
        
      addReconizer()
        
        // Do any additional setup after loading the view.
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.getProductDetails()
//
//        self.view2.addShadow()
        self.view3.addShadow()

    }
    
    @objc func appMovedToForeground() {
        print("App moved to ForeGround!")
    }
    
    @IBAction func onTapNewOrder(_ sender: UIControl) {
//            self.paymentContext.requestPayment()
//        let addProductVc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
//         self.present(addProductVc, animated: true, completion: nil)
    }
    
    //MARK:- Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.orderTableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell", for: indexPath) as! OrderHistoryCell
        if let orderDetails = order[indexPath.row] as? NSDictionary {
            cell.lblNameValue.text = orderDetails["name"] as? String
            cell.lblQuntyValue.text = orderDetails["quanity"] as? String
            cell.addShadow()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    
    //MARK:-API Calling
    func getProductDetails () {
        functions.httpsCallable("searchShop").call(["uid": uid]) { (result, error) in
            
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // ...
            }
            if let orderObj = result?.data as? NSDictionary {//(result?.data as? [String: Any]) {
                if let orderCount = orderObj["orderCount"] as? String {
                    self.lblOrder.text = orderCount
                }
                
                if let profit = orderObj["profit"] as? String {
                    self.lblProfit.text = "$" + profit
                }
                
                if let orderArray = orderObj["orders"] as? NSArray {
                    self.order = orderArray
                    self.orderTableView.reloadData()
                }
                print(orderObj)
//                self.resultField.text = text
            }
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
    
    override func viewDidAppear(_ animated: Bool) {
        bubblesView.play()
    }

}
extension ShopMangeVC {
    @objc func addUserInfo(_ sender: UISwipeGestureRecognizer) {
    let controller:UserDetailViewController = self.storyboard!.instantiateViewController(withIdentifier:"UserDetailViewController") as!
                     UserDetailViewController
//
//
//    if (gesture.direction == .right) {
//        print("--->")
//                 UIView.animate(withDuration: 0.5) {
//
//
//                    controller.view.frame = self.view.bounds;
//                    self.scroll.addSubview(controller.view)
//                    self.addChild(controller)
//                    controller.didMove(toParent: self)
//
//               }
//
//    } else if gesture.direction == .left {
//          print("<---")
//        controller.view.removeFromSuperview()
//
//    }
//
//    print("swiped")
   
//    UIView.animate(withDuration: 0.5) {
//        self.view.alpha = 0
//    }
        
        
        
        if sender.direction == .left
           {
              print("Swipe left")
              // show the view from the right side
            controller.willMove(toParent: nil)
            controller.view.backgroundColor = .black
            controller.view.removeFromSuperview()
            controller.removeFromParent()
           }

           if sender.direction == .right
           {
              print("Swipe right")
                  UIView.animate(withDuration: 0.5) {
            
            
                                controller.view.frame = self.view.bounds;
                                self.scroll.addSubview(controller.view)
                                self.addChild(controller)
                                controller.didMove(toParent: self)
            
                           }
            
              // show the view from the left side
           }
 
 
    }
}

