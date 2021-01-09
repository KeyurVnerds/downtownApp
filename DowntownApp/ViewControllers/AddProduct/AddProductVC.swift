//
//  AddProductVC.swift
//  DowntownApp
//
//  Created by keyur on 6/1/2564 BE.
//  Copyright © 2564 Aaron Marsh. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import FirebaseDatabase
import FirebaseFunctions

class AddProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UITextViewDelegate {
        

    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var productPrice: HoshiTextField!
    @IBOutlet weak var productVarietiion: HoshiTextField!
    @IBOutlet weak var tfProductTitle: HoshiTextField!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        }
    }
    
    var productImageList = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.productPrice.delegate = self
        self.productVarietiion.delegate = self
        self.tfProductTitle.delegate = self
        self.productPrice.keyboardType = .asciiCapableNumberPad
        self.txtDesc.textColor = UIColor.lightGray
        self.txtDesc.delegate = self        
    }
    
    @IBAction func btnAddProductAction(_ sender: UIControl) {
        self.picker()
    }
    
    //MARK:- Collectionview delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.imgView.image = self.productImageList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 150.0)
    }

    
    func picker() {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openGallary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
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

extension AddProductVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.productImageList.append(tempImage)
        }
        
//        if let tempImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            image = tempImage
//            self.productImageList.append(tempImage)
//        }
        self.dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
    }
    
    //MARK:- Textfield delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            textField.setIcon(#imageLiteral(resourceName: "tick"))
        }
    }
    
    //MARK:- Text view delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write here"
            textView.textColor = UIColor.lightGray
        }
    }
}
