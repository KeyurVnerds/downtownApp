//
//  BasicStuff.swift
//  DowntownApp
//
//  Created by keyur on 6/1/2564 BE.
//  Copyright © 2564 Aaron Marsh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Stripe
import FirebaseDatabase


let publicKey = "pk_test_LNY5fjEFqFhUORrCHueKrW26"
let seckretKey = "sk_test_hgHDQOYRrTlk581vcW1cvNmT"
let stripeBaseUrl = "https://api.stripe.com"
   var paymentContext = STPCustomerContext(keyProvider: MyAPIClient())

//let stripeUserId = Database.database().reference().child(uid!).child("StripeSecure/id") //ref.child(uid!).child("StripeSecure/id").observeSingleEvent(of: .value)


struct JSN {
    static var isNetworkConnected:Bool = false
    static func log(_ logMessage: String,_ args:Any... , functionName: String = #function ,file:String = #file,line:Int = #line) {
        
        let newArgs = args.map({arg -> CVarArg in String(describing: arg)})
        let messageFormat = String(format: logMessage, arguments: newArgs)
        
        print("LOG :- \(((file as NSString).lastPathComponent as NSString).deletingPathExtension)--> \(functionName) ,Line:\(line) :", messageFormat)
    }
    static func error(_ logMessage: String,_ args:Any... , functionName: String = #function ,file:String = #file,line:Int = #line) {
        
        let newArgs = args.map({arg -> CVarArg in String(describing: arg)})
        let messageFormat = String(format: logMessage, arguments: newArgs)
        
        print("ERROR :- \(((file as NSString).lastPathComponent as NSString).deletingPathExtension)--> \(functionName) ,Line:\(line) :", messageFormat)
    }
}



extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


extension UIView {
    
    func addShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addLightShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.masksToBounds = false
        clipsToBounds = false
    }
}

extension UIViewController {
    func showAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}


class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {

    func createCustomerKey(withAPIVersion apiVersion: String = "19.1.0", completion: @escaping STPJSONResponseCompletionBlock) {

        var urlStr = "https://downtown-proxy.herokuapp.com/create_charge?uid="//stripeBaseUrl.appending("ephemeral_keys")
        var param = [String:String]()
        getStripeId { (stripeId) in
            urlStr = urlStr + stripeId
//            param["customer"] = stripeId
        }
        
       // param["customer"] = //reference(uid!).reference("StripeSecure/id") //User.getStripeId() //UserModel.shared.objUser?.user?.stripe_id ?? ""
//        let header = ["Authorization":"Bearer " + seckretKey, "Stripe-Version":"2020-08-27"]

        Alamofire.request(urlStr,method: .get, parameters: param,headers: nil)
            .validate(contentType: ["application/x-www-form-urlencoded"])
            .responseJSON { (response) in
                if response.data != nil {

                    guard let data = response.data else {
                        return
                    }
                    JSN.log("ephemeral key response ===>%@", String(bytes: data, encoding: .utf8))

                    do {
                        StripeModel.shared.stripeObj = try JSONDecoder().decode(SkripeKeyData.self, from: data)
                        let disctionaryValue = StripeModel.shared.stripeObj?.dictionary
                        completion(disctionaryValue,nil)

                    } catch let error {
                        JSN.log("error ====>%@", error.localizedDescription)
                    }
                }else {
                    JSN.log("secret key error ===>%@", response.error.debugDescription)
                }
            }

    }
}

class PresentationController: UIPresentationController {

  let blurEffectView: UIVisualEffectView!
  var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
  
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    let blurEffect = UIBlurEffect(style: .systemMaterialDark)
      blurEffectView = UIVisualEffectView(effect: blurEffect)
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
      tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      self.blurEffectView.isUserInteractionEnabled = true
      self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
      CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.4),
             size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
              0.6))
  }

  override func presentationTransitionWillBegin() {
      self.blurEffectView.alpha = 1
      self.containerView?.addSubview(blurEffectView)
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
          self.blurEffectView.alpha = 0.7
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
  }
  
  override func dismissalTransitionWillBegin() {
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
          self.blurEffectView.alpha = 0
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in
          self.blurEffectView.removeFromSuperview()
      })
  }
  
  override func containerViewWillLayoutSubviews() {
      super.containerViewWillLayoutSubviews()
    presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
  }

  override func containerViewDidLayoutSubviews() {
      super.containerViewDidLayoutSubviews()
      presentedView?.frame = frameOfPresentedViewInContainerView
      blurEffectView.frame = containerView!.bounds
  }

  @objc func dismissController(){
      self.presentedViewController.dismiss(animated: true, completion: nil)
  }
}

extension UIView {
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
  }
}

class OverlayView: UIViewController {
    
    @IBOutlet weak var container: UIView!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    @IBOutlet weak var slideIdicator: UIView!


    @IBOutlet weak var purchase: UIView!
    //    @IBOutlet weak var purchase: UIButton!
//    @IBAction func purchaseAction(_ sender: Any) {
//
//
//    }
    
    
    func style() {
        purchase.layer.borderWidth = 3
        purchase.layer.cornerRadius = 25
        purchase.layer.borderColor = UIColor.black.cgColor
        
    }
    override func viewDidLoad() {
        style()
        view.backgroundColor = .white
        super.viewDidLoad()
         let customerContext = STPCustomerContext(keyProvider: MyAPIClient())
        
            
              paymentContext.delegate = self
            paymentContext.hostViewController = self
        //        self.paymentContext.paymentAmount = 5000
                paymentContext.paymentCurrency = "USD"
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        
    
//        view.backgroundColor = .white
//
//        slideIdicator.roundCorners(.allCorners, radius: 10)
//        subscribeButton.roundCorners(.allCorners, radius: 10)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
          guard !STPPaymentConfiguration.shared().publishableKey.isEmpty else {
              JSN.error("Please assign a value to `publishableKey` in StripeConstants.swift and make sure it is used to setup Stripe in AppDelegate.")
              return
          }
  
  
         if paymentContext.hostViewController == nil {
             paymentContext.hostViewController = self
         }
                 // Present the Stripe payment methods view controller to enter payment details
         paymentContext.requestPayment()
        print("tapped")
        //presentPaymentOptionsViewController()
    }

     var paymentContext = STPPaymentContext()
    
    override func viewDidLayoutSubviews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
       purchase.addGestureRecognizer(tap)

        // Then, you should implement the handler, which will be called each time when a tap event occurs:

        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
extension OverlayView: STPPaymentContextDelegate {
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        let header = ["Authorization":"Bearer " + seckretKey]
        var params = ["productId": globalProductId, "uid": uid!, "qaunity": quanity,"detail":globalDetails] as [String : Any]
    
        
          getStripeId { (stripeId) in
            params["customer"] = stripeId
        Alamofire.request("https://downtown-proxy.herokuapp.com/postOrder",method: .post, parameters: params,headers: header)
                     .validate(contentType: ["application/x-www-form-urlencoded"])
                     .responseJSON { (response) in
                         if let data = response.data {
                             let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??)
                             print(response.result.value)
                             JSN.log("Secret key ====>%@", json??["client_secret"] as? String)
                             if let sKey = json??["client_secret"] as? String {
                                 print(sKey)
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
                             self.showAlert(title: "Alert", message: "Something went wrong")
                         }
                         
                     
             
    }
    }
    }
    
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        JSN.log("didFailToLoadWithError error ====>%@", error)
    }
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        JSN.log("paymentContext.selectedPaymentOption?.label ====>%@", paymentContext.selectedPaymentOption?.label)
        JSN.log("paymentContext.selectedPaymentOption?.image ====>%@", paymentContext.selectedPaymentOption?.image)
    }
    

    
    
    func paymentContext(_ paymentContext : STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        JSN.error("payment cotext delegate error ====>%@", error)
    }
    
}
    
    
    


