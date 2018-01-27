//
//  VeiculoInformationModel.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 22/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

/*
 
 {
 "id": "2013",
 "ano_modelo": "2013",
 "marca": "Fiat",
 "name": "Palio 1.0 ECONOMY Fire Flex 8V 4p",
 "veiculo": "Palio 1.0 ECONOMY Fire Flex 8V 4p",
 "preco": "R$ 23.055,00",
 "combustivel": "Gasolina",
 "referencia": "agosto de 2015",
 "fipe_codigo": "001267-0",
 "key": "palio-2013"
 }
 
 */


import Foundation


class VeiculoInformationModel : NSObject {
    
    var id:String?
    var ano_modelo:String?
    var marca:String?
    var name:String?
    var veiculo:String?
    var preco:String?
    var combustivel:String?
    var referencia:String?
    var fipe_codigo:String?
    var key:String?
    
    convenience init(forJSON object:[String:Any]) {
        self.init()
        
        guard let id = object["id"] as? String else {
            return
        }
        self.id = id
        
        guard let ano_modelo = object["ano_modelo"] as? String else {
            return
        }
        self.ano_modelo = ano_modelo
        
        guard let marca = object["marca"] as? String else {
            return
        }
        self.marca = marca
        
        guard let name = object["name"] as? String else {
            return
        }
        self.name = name
        
        guard let veiculo = object["veiculo"] as? String else {
            return
        }
        self.veiculo = veiculo
        
        guard let preco = object["preco"] as? String else {
            return
        }
        self.preco = preco
        
        guard let combustivel = object["combustivel"] as? String else {
            return
        }
        self.combustivel = combustivel
        
        guard let referencia = object["referencia"] as? String else {
            return
        }
        self.referencia = referencia
        
        guard let fipe_codigo = object["fipe_codigo"] as? String else {
            return
        }
        self.fipe_codigo = fipe_codigo
        
        guard let key = object["key"] as? String else {
            return
        }
        self.key = key
    }
}
