//
//  MarcaModel.swift
//  WebServiceTabelaFipe
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//


/*
 { "name": "AUDI",
   "fipe_name": "Audi",
   "order": 2,
   "key": "audi-6",
   "id": 6
 }
 */

import Foundation

class MarcaModel: NSObject {
    
    var name:String?
    var fipe_name:String?
    var order:Int?
    var key:String?
    var id:Int?
    
    convenience init(forJSON object:[String:Any]) {
        
        self.init()
        
        guard let name = object["name"] as? String else {
            return
        }
        self.name = name
        
        guard let fipe_name = object["fipe_name"] as? String else {
            return
        }
        self.fipe_name = fipe_name
        
        guard let order = object["order"] as? Int else {
            return
        }
        self.order = order
        
        guard let key = object["key"] as? String else {
            return
        }
        self.key = key
        
        guard let id = object["id"] as? Int else {
            return
        }
        self.id = id
    }
}
