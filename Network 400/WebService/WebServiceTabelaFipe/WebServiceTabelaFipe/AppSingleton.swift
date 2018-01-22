//
//  AppSingleton.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 22/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

enum Type:String {
    case veiculo
    case marca
    case modelo
    case other
}

class AppSingleton {
    
    static let shared = AppSingleton()
    private init() {}
    
    func recovery(informationFor endPoint:String, completation:@escaping (Bool,[[String:Any]]?)->()) -> Void {
        
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        guard let url = URL(string: uri) else {
            completation(false,nil)
            return
        }
    
        let session = URLSession(configuration: .default)
        let task    = session.dataTask(with: url) { (data, response, error) in
            if let erro = error {
               completation(false,nil)
            }
            
            if let dataReceive = data {
               do {
                  guard let arrayObject = try JSONSerialization.jsonObject(with: dataReceive, options: JSONSerialization.ReadingOptions()) as? [[String:Any]] else {
                      completation(false,nil)
                      return
                  }
                  completation(true,arrayObject)
               } catch let erro {
                    completation(false,nil)
                    print("Error parse \(erro.localizedDescription)")
               }
            }
        }
        task.resume()
    }
}
