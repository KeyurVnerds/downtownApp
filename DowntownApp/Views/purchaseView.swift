//
//  purchaseView.swift
//  DowntownApp
//
//  Created by Aaron Marsh on 1/17/21.
//  Copyright © 2021 Aaron Marsh. All rights reserved.
//

import Foundation
import Stripe
import UIKit
import Alamofire
class purchaseView: UIView {
    @IBOutlet weak var view: UIView!
    private func style() {
        self.view.frame.size = superview!.frame.size
    }
    
    
    
}
extension purchaseView: STPPaymentContextDelegate{
    
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
                                    let vc = itemView()
                                       vc.alert(title: "Error", message: "Sorry Please Try Again")
                                 
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
                        let vc = itemView()
                        vc.alert(title: "Error", message: "Something Went Wrong")
                     }
                     
                 }
         }
     }
     
     func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
         JSN.error("payment cotext delegate error ====>%@", error)
     }
     
     
     
}
