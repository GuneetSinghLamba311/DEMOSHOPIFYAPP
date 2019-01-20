//
//  StartViewController.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-20.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct products {
    var title:String
    var description:String
    var imgSrc:URL
    var productId: String
    var detailedDescription: String
}

class StartViewController: UIViewController {
 let ShoipfyURL = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    var productObject = [products]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(ShoipfyURL, method: .get, parameters: nil).responseJSON {
            
            (response) in
            
            if response.result.isSuccess {
                if let dataFromServer = response.data {
                    
                    
                    do {
                        let json = try JSON(data: dataFromServer)
                        print("total number of products: \(json["products"].count)")
                        
                        for i in 0...json["products"].count-1 {
                            self.productObject.append(products(title: String(describing: json["products"][i]["title"]), description: String(describing: json["products"][i]["body_html"]), imgSrc: URL.init(string: String(describing: json["products"][i]["images"][0]["src"]))!, productId:String(describing: json["products"][i]["id"]), detailedDescription: ""))
                            
                            
                        }
                    }
                    catch {
                        print("error")
                    }
                    
                }
                else {
                    print("Error when getting JSON from the response")
                }
            }
        }
    }
    
    @IBAction func showProducts(_ sender: Any) {
        
        performSegue(withIdentifier: "showProducts", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let ViewController =  segue.destination as? UINavigationController
        let controller: HomeController = ViewController!.topViewController as! HomeController
        controller.productObject = self.productObject
    }

    
   
}
