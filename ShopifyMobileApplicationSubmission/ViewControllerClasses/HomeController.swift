//
//  HomeController.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-09.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var testImage: UIImageView!
    
    var Collection = [String:[Dictionary<String, Any>]]()
    var imageCollections = [Dictionary<String, Any>]()
    var collectionId = [Any]()
    var ImagesUrl = [Any]()
    var imageData = [NSData]()
    var images = [UIImage]()
    @IBOutlet weak var productsCollectionList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionList.delegate = self
        productsCollectionList.dataSource = self
         getCollectionList()
}
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionViewCell
        DispatchQueue.global().async {
            
            do {
                for i in 0...16 {
                    try self.imageData.append(NSData(contentsOf: URL(string: self.ImagesUrl[i] as! String)!))
                    self.images.append(UIImage(data: self.imageData[i] as Data)!)
                }
            }
            catch {
                print("error")
            }
        }
        DispatchQueue.main.async {
            
            self.testImage.image = self.images[0]
            cell.ProductImage.image = self.images[indexPath.row]
        //cell.ProductLabel.text = collectionId[indexPath.row] as! String
        }
            return cell
    }
    
    
   
    func getCollectionList() {
        
        
        
        if let url = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                            self.Collection = jsonString as! [String : [Dictionary]]
                            //print(self.Collection)
                            // getting collectionId and saving them into arrays.
                            
                            for idCount in self.Collection {
                                for idSize in 0...16 {
                                    self.collectionId.append(idCount.value[idSize]["id"]!)
                                }
                            }
                            
                            
                            // getting image URLS and saving it into dictionary.
                            for count in self.Collection {
                                for size in 0...16 {
                                    self.imageCollections.append(count.value[size]["image"] as! [String : Any])
                                    //self.imageCollections count.value[size]["image"] as! [Dictionary<String, Any>]
                                    self.ImagesUrl.append(self.imageCollections[size]["src"]!)
                                    
                                    }
                                
                                
 
                                
                                
                                print(self.collectionId.count)
                                print(self.imageCollections[0]["src"] as! String)
                                print(self.collectionId[0])
                                print(self.ImagesUrl.count)
                                print(self.ImagesUrl[0])
                                //print(self.imageData[0])
                                print(self.images.count)
                                
                            }
                        
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
                }.resume()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*func getproductId() {
        if let url = URL(string: "https://shopicruit.myshopify.com/admin/collects.json?collection_id=68424466488&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                            self.Collection = jsonString as! [String : [AnyObject]]
                            //print(self.Collection)
                            for a in self.Collection
                            {
                                print(a.value)
                                for i in 0...16{
                                    // asssign Collectionids to Collection ID Array
                                    self.CollectionID = a.value[i]["id"] as! [String]
                                    
                                }
                                
                                
                                
                            }
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
                }.resume()
        }
      }
    */
    
    
    
    
    
    
}
   


