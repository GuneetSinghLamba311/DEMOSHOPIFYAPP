//
//  StartViewController.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-20.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
import Alamofire                // AlamoFireLibrary - Used For API Requests and getting data from server
import SwiftyJSON               // SwiftyJson - Used for parsing json received from url request.

struct products {               // Structure to save data received from server.
    var title:String
    var description:String
    var imgSrc:URL
    var productId: String
    var detailedDescription: String
}

// Class for initialController.
// In this class data received from api by using alamofire-request method and pasrsing json using swfityJson method.
class StartViewController: UIViewController {
    
 let ShopifyProductsURL = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    var productObject = [products]() // Created  array of objects of products-Structure which will store data of various custom collections.
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(ShopifyProductsURL, method: .get, parameters: nil).responseJSON {
            
            (response) in
            
            if response.result.isSuccess {   /// if response give result then execute following code.
                
                if let dataFromServer = response.data { // getting data from response.
                    
                    
                    do {
                        let json = try JSON(data: dataFromServer) // Parsing Json received from server.
                        print("total number of products: \(json["products"].count)")
                        
                        for i in 0...json["products"].count-1 {
                            // here structure objects are being appended with data.
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
        // Performing segue on clicking button.
        performSegue(withIdentifier: "showProducts", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Passing data to another view controller where object another object of product-Structure is created. By this we can call all structue properties using loop.
    let ViewController =  segue.destination as? UINavigationController
        let controller: HomeController = ViewController!.topViewController as! HomeController
        controller.productObject = self.productObject
    }

    
   
}
