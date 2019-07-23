//
//  Order.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/23/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit

class Order: NSObject {
    
    var id: String?
    
    var internalGuide: Int?
    
    var guide: Int?
    
    var messengerId: Int?
    
    var status: String?
    
    var createdAt: String?
    
    var statusOrder: String?
    
    init(id: String, internalGuide: Int, guide: Int, messengerId: Int, status: String, createdAt: String, statusOrder: String) {
        
        self.id = id
        
        self.internalGuide = internalGuide
        
        self.guide = guide
        
        self.messengerId = messengerId
        
        self.status = status
        
        self.createdAt = createdAt
        
        self.statusOrder = statusOrder
    }

}
