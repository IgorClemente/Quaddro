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
    
    func recovery(informationFor endPoint:String, completation:@escaping (Bool,[[String:Any]]?,Error?)->()) -> Void {
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        guard let url = URL(string: uri) else {
            completation(false,nil,nil)
            return
        }
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let session = URLSession(configuration: .default)
        let task    = session.dataTask(with: url) { (data, response, error) in
            if let erro = error {
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
               completation(false,nil,erro)
            }
            
            if let dataReceive = data {
               DispatchQueue.main.async {
                  UIApplication.shared.isNetworkActivityIndicatorVisible = false
               }
               do {
                  guard let arrayObject = try JSONSerialization.jsonObject(with: dataReceive, options: JSONSerialization.ReadingOptions()) as? [[String:Any]] else {
                      completation(false,nil,nil)
                      return
                  }
                  completation(true,arrayObject,nil)
               } catch let erro {
                    completation(false,nil,erro)
                    print("Error parse \(erro.localizedDescription)")
               }
            }
        }
        task.resume()
    }
}
