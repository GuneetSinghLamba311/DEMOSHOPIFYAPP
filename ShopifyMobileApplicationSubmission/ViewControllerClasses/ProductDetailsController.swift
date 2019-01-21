//
//  ProductDetailsController.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-09.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ProductDetailsController: UIViewController {

    var productsId:String? // getting from HomeController.
    var imgURL:URL?         // gettin from HomeController.
    
    // Outlets for displaying data to user for specific item.
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Product Details URL
        let ShopifyDetailsurl = "https://shopicruit.myshopify.com/admin/products/\(self.productsId!).json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        // using alamofire for request.
        Alamofire.request(ShopifyDetailsurl, method: .get, parameters: nil).responseJSON {
            
            (response) in
            
            if response.result.isSuccess {
                if let dataFromServer = response.data {
                    
                    
                    do {
                        let json = try JSON(data: dataFromServer)
                        print("Product ID = \(self.productsId!)")
                        print("Title = \(json["product"]["title"])")
                        print("Detailed Description = \(json["product"]["body_html"])")
                        print("Vendor = \(json["product"]["vendor"])")
                        print("Product_Type = \(json["product"]["product_type"])")
                        print("Price = \(json["product"]["variants"][0]["price"])")
                     
                        do {
                            let data: Data = try Data.init(contentsOf: self.imgURL!)
                            self.productImage.image=UIImage(data:data)
                        
                        }
                        catch {
                            
                        }
                        
                    self.productID.text = "ProductID: \(self.productsId!)"
                    self.productTitle.text = String(describing: json["product"]["title"])
                    self.productDescription.text = String(describing: json["product"]["body_html"])
                        self.productPrice.text = "$ \(String(describing: json["product"]["variants"][0]["price"]))"
                    self.productType.text = String(describing: json["product"]["product_type"])
                            
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
    

}
