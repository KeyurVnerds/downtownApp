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


class ShopMangeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblOrder: UILabel!
    
    @IBOutlet weak var view3: UIControl!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var orderTableView: UITableView!{
        didSet {
            orderTableView.register(UINib(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
        }
    }
    
    @IBOutlet weak var lblProfit: UILabel!
    
    var order:NSArray = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.getProductDetails()
        self.view1.addShadow()
        self.view2.addShadow()
        self.view3.addShadow()

    }
    
    @IBAction func onTapNewOrder(_ sender: UIControl) {
        let addProductVc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
         self.present(addProductVc, animated: true, completion: nil)
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

}
