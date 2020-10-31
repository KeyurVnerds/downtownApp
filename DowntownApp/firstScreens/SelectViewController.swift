//
//  SelectViewController.swift
//  Downtown
//
//  Created by Aaron Marsh on 11/22/19.
//  Copyright © 2019 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
 import AVKit
import AVFoundation
import Lottie
var bgg = #colorLiteral(red: 0.0471, green: 0.0157, blue: 0.0078, alpha: 1)


class SelectViewController: UIViewController {
    

    func alreadyLoggedIn() {
        
        
        if Auth.auth().currentUser != nil {
            
            delay(0.00000000000001) {
                self.performSegue(withIdentifier: "ready", sender: self)
            }
            initializeData()
            
            
        }
        
        
        
    }
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!

    @IBOutlet weak var backGround: UIImageView!
    func setWallpaper() {
        backGround.translatesAutoresizingMaskIntoConstraints = false
        backGround.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGround.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGround.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGround.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGround.contentMode = .scaleToFill
        backGround.image = UIImage(named: "selectBackground")
        
        
    }
    @objc func toLogin() {
        performSegue(withIdentifier: "login", sender: self)
    }
    @objc func toSignUp() {
         performSegue(withIdentifier: "register", sender: self)
     }
    var loginButton: UIButton {
 let button = UIButton(frame: CGRect(x: 70 , y: 680, width: 235, height: 55))
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.setTitle("Login with Email", for: .normal)
        button.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "Login"), for: .normal)
        button.layer.cornerRadius = 10
        button.sizeToFit()
        return button
    }
      var signUpButton: UIButton {
    let button = UIButton(frame: CGRect(x: 70, y: 615, width: 235, height: 55))
           button.backgroundColor = .black
           button.titleLabel?.textColor = .white
           button.setTitle("Create Account", for: .normal)
           button.addTarget(self, action: #selector(toSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.sizeToFit()
           return button
       }
       
    
    
    
    func text_animation() {
       
        UIView.animate(withDuration: 1,
          delay: 1,
          options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
          animations: {
            self.downtownLabel.alpha = 0

        })
//       delay(1){
//        UIView.animate(withDuration: 1) {
//            self.downtownLabel.alpha = 1
//           }
//        }
        
    
    }
    func bubblesEffect() {
        

         
         // 2. Start AnimationView with animation name (without extension)
        let bubblesView: AnimationView
        bubblesView = .init(name: "bubbles")
        
        print("animation??????")
         
        bubblesView.frame.size = view.frame.size
         
         // 3. Set animation content mode
         
        bubblesView.contentMode = .scaleAspectFill
         
         // 4. Set animation loop mode
         
        bubblesView.loopMode = .loop
         
         // 5. Adjust animation speed
         
        bubblesView.animationSpeed = 0.7
         
         view.addSubview(bubblesView)
         
         // 6. Play animation
         
        bubblesView.play()
        
    }
 
    
    
    var downtownLabel: UILabel {
         
         let label = UILabel()
         
        label.frame.size = CGSize(width:self.view.frame.width, height: 200)
        
        label.textAlignment = .center
         
         label.font = UIFont(name: "Kefa", size: 50)
         
         label.textColor = .black
//        label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))

         
        label.backgroundColor = .clear
        
        
        
        
      
//
        label.text = "Downtown"
//
//        view.addSubview(label)
     
         print(233838)
         return label
     }
     func customPage() {
    
        print("mm ")
         
        view.backgroundColor = offWhite

//         self.view.backgroundColor = offWhite
         self.view.addSubview(downtownLabel)
     }
    
    override func viewDidLoad() {

//        self.view.backgroundColor = .white
//        alreadyLoggedIn()
   text_animation()
    customPage()
       setWallpaper()
//        do {
//            try Auth.auth().signOut()
//        }
//        catch {
//            return
//        }
        alreadyLoggedIn()
       
        bubblesEffect()
  view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        
        
     
            
//        blur()
 
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loopVideo(player: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
           player.seek(to: CMTime.zero)
            player.play()
          
        }
    }
}

