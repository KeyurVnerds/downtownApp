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

