//
//  OrderHistoryVC.swift
//  DowntownApp
//
//  Created by keyur on 9/1/2564 BE.
//  Copyright © 2564 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFunctions


class OrderHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        
    @IBOutlet weak var lblProfit: UILabel!
    @IBOutlet weak var lblOrderCount: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: "OrderHistoryCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryCell")
        }
    }
    
    var order:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getProductDetails()
    }
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell", for: indexPath) as! OrderHistoryCell
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
                    self.lblOrderCount.text = orderCount
                }
                
                if let profit = orderObj["profit"] as? String {
                    
                }
                
                if let orderArray = orderObj["orders"] as? NSArray {
                    self.order = orderArray
                    self.tableView.reloadData()
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
