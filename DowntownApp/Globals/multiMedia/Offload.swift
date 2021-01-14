
import FirebaseAuth
import FirebaseDatabase
import FirebaseFunctions

public var uid = Auth.auth().currentUser?.uid
let ref = Database.database().reference()
var downloadPro = 0
var image = UIImage(named: "djfm")
let auth = Auth.auth()
    // for auth Var//
var firstname = "Aaron"
var lastname = "Marsh"
var email = "email"
var password = ""
var cardVal = 406
var expD = 08/24
var cvv = 792
var signupCB = ""
var updateState = ""
var updateStateV = ""
var stateVal = ""
  var popularSL = ""
var popularIC = ""
var functions = Functions.functions()
var images = Array<Any>()

public var prices = ["", "","","","","","","",""]
public var labell =  ["", ""]
 
public var searchableJ = NSObject()
var inDepthL = ""

var imageArray = [UIImage]()
var imageURLA = Array<Any>()
    public var SellerEmail = ""
var ChildSelectedPath = ""
var currentDictionary = NSDictionary()
         
 let index = [0,1] as! IndexPath

 
func findUserEmail (json: NSDictionary, userEmail: String) -> String{
    if let dictionary =  json as? [String: Any] {
                              if let sellerE = dictionary["sellerEmail"] as? String {
             SellerEmail = sellerE
   print(userEmail)
                                // access individual value in dictionary
                            }
            }

    return userEmail
    
}

func resetP(){
    
    
    ref.child("users").child(uid!).child("email").observeSingleEvent(of: .value) { (emailC) in
        let emailCall = emailC.value as! String
    
    
    Auth.auth().sendPasswordReset(withEmail: emailCall) { error in
        
        
        
    }
    }
    
}

func getStripeId(_ completion:@escaping((String)->())) {
    ref.child(uid!).child("securePayment/stripeId").observeSingleEvent(of: .value) { (stripeDetails) in
        if let stripeId = (stripeDetails.value as? NSDictionary)?["stripeId"] as? String {
            completion(stripeId)
        }
    }

}





public struct order_data {
     var image: String
     var orderId: String
     var shop: String
     var name: String
    var price: String
     
    init(image: String, orderId: String, shop: String, name: String, price: String) {
         self.image = image
         self.orderId = orderId
         self.shop = shop
         self.name = name
         self.price = price
        
        }
 }
 
