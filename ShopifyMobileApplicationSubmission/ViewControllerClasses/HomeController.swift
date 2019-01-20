//
//  HomeController.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-09.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    var productObject  = [products]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productObject.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionViewCell
        do {
        let data: Data = try Data.init(contentsOf: productObject[indexPath.row].imgSrc)
        cell.ProductImage.image=UIImage(data:data)
            cell.ProductLabel.text = productObject[indexPath.row].title
            cell.productDescription.text = productObject[indexPath.row].description
        }
        catch{
            print(error)
        }
        
        
    return cell
   
 }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! ProductDetailsController
        ViewController.productsId = productObject[index].productId
        ViewController.imgURL = productObject[index].imgSrc
        
}
    
    
    
    
    
    
    
}
