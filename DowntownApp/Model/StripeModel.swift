//
//  StripeModel.swift
//  DowntownApp
//
//  Created by keyur on 14/01/21.
//  Copyright © 2021 Aaron Marsh. All rights reserved.
//

import Foundation


class StripeModel: NSObject {
    static let shared = StripeModel()
    var stripeObj:SkripeKeyData?
}

class StripeResponse: Codable {
    var status:Bool?
    var stripe_key:SkripeKeyData?
    
}

class SkripeKeyData: Codable {
    var id:String?
    var object:String?
    var associated_objects:[Associated_objectsData]?
    var created:Double?
    var expires:Double?
    var livemode:Bool?
    var secret:String?
}

class Associated_objectsData: Codable {
    var id:String?
    var type:String?
}

