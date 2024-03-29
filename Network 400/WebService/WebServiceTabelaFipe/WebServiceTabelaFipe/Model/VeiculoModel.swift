//
//  Veiculo.swift
//  WebServiceTabelaFipe
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//


import Foundation

class VeiculoModel: NSObject {
    
    var fipe_marca:String?
    var name:String?
    var marca:String?
    var key:String?
    var id:String?
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
        
        guard let key = object["key"] as? String else {
            return
        }
        self.key = key
        
        guard let id = object["id"] as? String else {
            return
        }
        self.id = id
        
        guard let fipe_name = object["fipe_name"] as? String else {
            return
        }
        self.fipe_name = fipe_name
    }
}
