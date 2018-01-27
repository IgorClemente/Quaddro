//
//  Modelo.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 21/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

/*
 
 {
  "fipe_marca": "Fiat",
  "fipe_codigo": "2014-1",
  "name": "2014 Gasolina",
  "marca": "FIAT",
  "key": "2014-1",
  "veiculo": "Palio 1.0 ECONOMY Fire Flex 8V 4p",
  "id": "2014-1"
 }
 
 
 */

import Foundation

class ModeloModel: NSObject {
    
    var fipe_codigo:String?
    var name:String?
    var marca:String?
    var key:String?
    var veiculo:String?
    var id:String?
    
    convenience init(forJSON object:[String:Any]) {
        self.init()
        
        guard let fipe_codigo = object["fipe_codigo"] as? String else {
            return
        }
        self.fipe_codigo = fipe_codigo
        
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
        
        guard let veiculo = object["veiculo"] as? String else {
            return
        }
        self.veiculo = veiculo
        
        guard let id = object["id"] as? String else {
            return
        }
        self.id = id
    }
}
