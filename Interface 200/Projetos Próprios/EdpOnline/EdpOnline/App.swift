//
//  App.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 09/10/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import Foundation
import Alamofire

class App {

    static let shared = App()
    private init() {}

    var userCpf = "45124712864"
    var amountOfTrees = 0
    var idTrees = Array<[String:Int]>()
    
    // MARK: user default - setup - persitense
    
    var ud  = UserDefaults.standard
    
    private var userLoggedInfos:[String:Any] = [:]
    
    func setUserLogged(_ user:[String:Any]) -> Void {
        guard let nome       = user["nome"] as? String,
              let sobrenome  = user["sobrenome"] as? String,
              let localidade = user["localidade"] as? String,
              let id_user    = user["id_user"] as? Int,
              let uf         = user["uf"] as? String,
              let numeroTelefone = user["numeroTelefone"] as? String,
              let email      = user["email"] as? String,
              let pontos     = user["pontos"] as? Int
        else {
            return
        }
        self.userLoggedInfos = user
        var salvo = ud.object(forKey: "userLogged") as? [String:Any] ?? [:]
        salvo["nome"] = nome
        salvo["sobrenome"] = sobrenome
        salvo["localidade"] = localidade
        salvo["id_user"]  = id_user
        salvo["uf"]      = uf
        salvo["numeroTelefone"] = numeroTelefone
        salvo["email"]   = email
        salvo["pontos"]  = pontos
        ud.set(salvo, forKey:"userLogged")
        ud.synchronize()
        print(user)
    }
    
    func getUserLogged() -> [String:Any]? {
        return ud.object(forKey: "userLogged") as? [String:Any] ?? [:]
    }
}
