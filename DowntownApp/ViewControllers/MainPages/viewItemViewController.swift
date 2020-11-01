import UIKit

class viewItem: UIViewController {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var minusButton: UIButton!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var imageIndex: Int = 0
    var itemNumber = 0
    
    @IBAction func buttonTapped(_sender: UIButton) {
        
        if _sender == addButton {
        itemNumber += 1
            
        numberLabel.text = String(itemNumber)
            
        }
        else {
            if itemNumber > 0{
                itemNumber -= 1
                
                numberLabel.text = String(itemNumber)
            }
            
        }
    }
    
    let imagesArray = [
        UIImage(named: "barrafina.jpg"),
        UIImage(named: "bourkestreetbakery.jpg"),
        UIImage(named: "cafelore.jpg"),
        UIImage(named: "cafeloisl.jpg"),
        UIImage(named: "cafedeadend.jpg"),
        UIImage(named: "confessional.jpg"),
        UIImage(named: "caskpubkitchen.jpg"),
        UIImage(named: "donostia.jpg"),
        UIImage(named: "fiveleaves.jpg"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.productImageView.image = imagesArray[0]
        pageControl.numberOfPages = imagesArray.count
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(gesture:))) // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        productImageView.isUserInteractionEnabled = true
        self.productImageView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(swiped(gesture:)))// put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.productImageView.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right :
                print("User swiped right")
                
                // check if index is in range
                imageIndex = imageIndex - 1
                
                if imageIndex < 0 {
                    imageIndex = imagesArray.count-1
                }
            
                self.productImageView.image = imagesArray[imageIndex]
                
            case UISwipeGestureRecognizer.Direction.left:
                print("User swiped Left")
                
                // increase index first
                
                imageIndex = imageIndex + 1
                
                // check if index is in range
                
                if imageIndex >= imagesArray.count {
                    imageIndex = 0
                }
                
                self.productImageView.image = imagesArray[imageIndex]
                
            default:
                break //stops the code/codes nothing.
            }
            pageControl.currentPage = imageIndex
            
        }
    }
}

