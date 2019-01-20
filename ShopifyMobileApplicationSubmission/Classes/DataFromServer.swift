//
//  DataFromServer.swift
//  ShopifyMobileApplicationSubmission
//
//  Created by Admin on 2019-01-20.
//  Copyright © 2019 Guneet SIngh Lamba. All rights reserved.
//

import Foundation

class products {
    
    var title:String?
    var productId:String?
    var description:String?
    var imgSrc:String?
    init(title:String,productId:String,description:String,imgSrc:String) {
        self.title = title
        self.productId = productId
        self.description = description
        self.imgSrc = imgSrc
}
}
