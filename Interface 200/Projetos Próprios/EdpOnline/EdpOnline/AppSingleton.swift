//
//  App.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 09/10/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire


struct Tree{
    var treeTitle    = ""
    var treeLocation = ""
    var treePoints   = 0
}

class App {

    static let shared = App()
    private init() {}
    
    var userCpf       = "45124712864"

    var amountOfTrees = 0
    var treesIndentifiers:[[String:Int]]?
    
    private var everybodyTrees = [[String:Any]]()
    private var trees = Dictionary<String,[String:Any]>()
    
    // MARK: Setup Singleton
    var currentLocation:CLLocationCoordinate2D? = nil
    private var ud  = UserDefaults.standard
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
    }
    
    func getUserLogged() -> [String:Any]? {
        return ud.object(forKey: "userLogged") as? [String:Any] ?? [:]
    }
    
    func toRecoverTreesDownload() -> [String:[String:[String:Any]]] {
        return ud.object(forKey: "salvedTrees") as? [String:[String:[String:Any]]] ??
            Dictionary<String,[String:[String:Any]]>()
    }
    
    func toRecoverEverybodyTrees() -> [[String:Any]] {
        saveTreesDownload()
        return self.everybodyTrees
    }
    
    func saveTreesDownload() -> Void {
        guard let identifiers = self.treesIndentifiers else {
            return
        }
        
        self.everybodyTrees = []
        
        for identifier in identifiers {
            guard let tree = identifier["arvore_id"],
                  let remoteURL = URL(string: "https://inovatend.mybluemix.net/imagens/arvore/\(tree)")
                  else {
                  return
            }
            
            Alamofire.request(remoteURL).responseData(completionHandler: {
                (response) in
                if response.error == nil,
                   let data = response.data {
    
                   guard let json = try? JSONSerialization.jsonObject(
                   with: data, options: JSONSerialization.ReadingOptions()),
                         let info     = json as? [String:Any],
                         let treeInfo = info["arvore"] as? [String:Any]
                         else {
                         return
                   }
                   self.trees["\(tree)"] = treeInfo
                   self.everybodyTrees.append(["\(tree)":treeInfo])
                    
                   var informationSalved = self.ud.object(forKey: "salvedTrees")
                    as? [String:[String:[String:Any]]] ?? [:]
                   informationSalved["trees"] = self.trees
                    
                   self.ud.set(informationSalved, forKey: "salvedTrees")
                   self.ud.synchronize()
                }
            })
        }
    }
}
