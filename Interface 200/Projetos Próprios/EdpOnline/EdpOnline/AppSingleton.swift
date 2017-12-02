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
    var treeId       = ""
    var treeTitle    = ""
    var treePoints   = 0
    var location:CLLocationCoordinate2D?
}

class App {

    static let shared = App()
    private init() {}
    
    var userCpf       = "45124712864"

    var amountOfTrees = 0
    var treesIndentifiers:[[String:Int]]?
    private var everybodyTrees = [[String:Any]]()
    
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
        salvo["nome"]       = nome
        salvo["sobrenome"]  = sobrenome
        salvo["localidade"] = localidade
        salvo["id_user"] = id_user
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
    
    func retrieveInformationTrees() -> [Tree]? {
        let treesSalved = ud.object(forKey: "trees") as? [String:Any] ?? nil
        var treesReturn = Array<Tree>()
        
        guard let trees = treesSalved else {
            return nil
        }
        
        for t in trees {
            guard let value = t.value as? [String:Any],
                  let title = value["titulo"] as? String,
                  let points    = value["pontos"] as? Int,
                  let longitude = value["longitude"] as? String,
                  let latitude  = value["latitude"] as? String,
                  let degreesLongitude:CLLocationDegrees = Double(longitude),
                  let degreesLatitude:CLLocationDegrees  = Double(latitude)
                  else{
                  return nil
            }
            
            let id    = t.key
            let location = CLLocationCoordinate2D(latitude: degreesLatitude, longitude: degreesLongitude)
            let newTree = Tree(treeId: id, treeTitle: title, treePoints: points, location: location)
            treesReturn.append(newTree)
        }
        return treesReturn
    }
    
    func saveInformationTrees() -> Void {
        
        self.ud.removeObject(forKey: "trees")
        guard let identifiers = self.treesIndentifiers,
              !identifiers.isEmpty else {
              return
        }

        for identifier in identifiers {
            guard let treeId = identifier["arvore_id"] else {
                return
            }
            DispatchQueue.global().async {
                guard let remoteURL = URL(string:
                "https://inovatend.mybluemix.net/imagens/arvore/\(treeId)"),
                      let treeInfoData = try? Data(contentsOf: remoteURL),
                      let json = try? JSONSerialization.jsonObject(with: treeInfoData, options: JSONSerialization.ReadingOptions()),
                      let info = json as? [String:Any],
                      let tree = info["arvore"] as? [String:Any]
                      else{
                      return
                }
                DispatchQueue.main.async {
                    var salved = self.ud.object(forKey: "trees") as? [String:Any] ?? [:]
                    salved["\(treeId)"] = tree
                    self.ud.set(salved, forKey: "trees")
                    self.ud.synchronize()
                }
            }
        }
    }
}
