//
//  Cep.swift
//  DesafioCEP
//
//  Created by Swift on 27/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//


import UIKit


class Cep: Codable {

    var logradouro:String
    var complemento:String
    var bairro:String
    var localidade:String
    var uf:String
    
    enum CodingKeys: String, CodingKey {
     case logradouro
     case complemento
     case bairro
     case localidade
     case uf
    }
    
    static func recovery(informationFor cep:String, completation:@escaping (Bool,Cep?)->()) {
        let uri = "https://viacep.com.br/ws/\(cep)/json/"
        guard let url = URL(string: uri) else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completation(false,nil)
                return
            }
            
            if let dataReceive = data {
               DispatchQueue.main.async {
                  UIApplication.shared.isNetworkActivityIndicatorVisible = false
               }
                
               let decoder = JSONDecoder()
               
               do {
                  let result = try decoder.decode(Cep.self, from: dataReceive)
                  DispatchQueue.main.async {
                     completation(true,result)
                  }
               } catch let error {
                  print("Error decoding \(error.localizedDescription)")
               }
            }
        }.resume()
     }
}
