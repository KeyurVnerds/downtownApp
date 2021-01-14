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
    
    var order:NSArray = []
    var paymentContext = STPPaymentContext()
    let customerContext = STPCustomerContext(keyProvider: MyAPIClient())

   private func addAnimation() {


    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
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
  
        
        
      
        
        // Do any additional setup after loading the view.
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.getProductDetails()
//
//        self.view2.addShadow()
        self.view3.addShadow()
        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        self.paymentContext.paymentAmount = 5000
        self.paymentContext.paymentCurrency = "USD"

    }
    
    @objc func appMovedToForeground() {
        print("App moved to ForeGround!")
    }
    
    @IBAction func onTapNewOrder(_ sender: UIControl) {
        guard !STPPaymentConfiguration.shared().publishableKey.isEmpty else {
            JSN.error("Please assign a value to `publishableKey` in StripeConstants.swift and make sure it is used to setup Stripe in AppDelegate.")
            return
        }
               
               
       if paymentContext.hostViewController == nil {
           paymentContext.hostViewController = self
       }
               // Present the Stripe payment methods view controller to enter payment details
        self.paymentContext.presentPaymentOptionsViewController()
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

//MARK:- Payment context delegate
extension ShopMangeVC: STPPaymentContextDelegate {
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        JSN.log("didFailToLoadWithError error ====>%@", error)
    }
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        JSN.log("paymentContext.selectedPaymentOption?.label ====>%@", paymentContext.selectedPaymentOption?.label)
        JSN.log("paymentContext.selectedPaymentOption?.image ====>%@", paymentContext.selectedPaymentOption?.image)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
       
        JSN.log("payment response ====>%@", paymentResult.paymentMethodParams?.card)
        
        var param = [String:Any]()
        param["amount"] = 5000
        param["currency"] = "USD"
        getStripeId { (stripeId) in
            param["customer"] = stripeId
        }
        
        let header = ["Authorization":"Bearer " + seckretKey]

        Alamofire.request("https://api.stripe.com/v1/payment_intents",method: .post, parameters: param,headers: header)
            .validate(contentType: ["application/x-www-form-urlencoded"])
            .responseJSON { (response) in
                if let data = response.data {
                    let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??)
                    print(response.result.value)
                    JSN.log("Secret key ====>%@", json??["client_secret"] as? String)
                    if let sKey = json??["client_secret"] as? String {
                        
                        let paymentIntentParams = STPPaymentIntentParams(clientSecret: sKey)
                        paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
                        
                
                        // Confirm the PaymentIntent
                        STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                            switch status {
                            case .succeeded:
                                // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                                self.showAlert(title: "Success", message: "your stripe id \(paymentIntent?.stripeId)")
                                completion(.success, nil)
                            case .failed:
                                completion(.error, error) // Report error
                            case .canceled:
                                completion(.userCancellation, nil) // Customer cancelled
                            @unknown default:
                                completion(.error, nil)
                            }
                        }

                    }
                }else {
                    self.showAlert(title: "Alert", message: "Something went wrog")
                }
                
            }
        
        
        
        
        
        
//        let paymentIntentParams = STPPaymentIntentParams(clientSecret: StripeModel.shared.stripeObj?.stripe_key?.secret ?? "")
//        paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
//
//        // Confirm the PaymentIntent
//        STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
//            switch status {
//            case .succeeded:
//                // Your backend asynchronously fulfills the customer's order, e.g. via webhook
//                completion(.success, nil)
//            case .failed:
//                completion(.error, error) // Report error
//            case .canceled:
//                completion(.userCancellation, nil) // Customer cancelled
//            @unknown default:
//                completion(.error, nil)
//            }
//        }
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        JSN.error("payment cotext delegate error ====>%@", error)
    }
    
    
    
    
}
