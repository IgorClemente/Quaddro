//
//  Veiculo.swift
//  WebServiceTabelaFipe
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

/*
 
 {
   "fipe_marca": "Peugeot",
   "name": "106 KID 1.0",
   "marca": "PEUGEOT",
   "key": "106-1834",
   "id": "1834",
   "fipe_name": "106 KID 1.0"
 }
 
 */


import Foundation

class Veiculo: NSObject {
    
    var fipe_marca:String?
    var name:String?
    var marca:String?
    var key:Int?
    var id:Int?
    var fipe_name:String?
    
    convenience init(forJSON object:[String:Any]) {
        self.init()
        
        guard let fipe_marca = object["fipe_marca"] as? String else {
            return
        }
        self.fipe_marca = fipe_marca
        
        guard let name = object["name"] as? String else {
            return
        }
        self.name = name
        
        guard let marca = object["marca"] as? String else {
            return
        }
        self.marca = marca
        
        guard let key = object["key"] as? Int else {
            return
        }
        self.key = key
        
        guard let id = object["id"] as? Int else {
            return
        }
        self.id = id
        
        guard let fipe_name = object["fipe_name"] as? String else {
            return
        }
        self.fipe_name = fipe_name
    }
}
