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
    var treeId       = 0
    var treeTitle    = ""
    var treePoints   = 0
    var location:CLLocationCoordinate2D?
}

class App {

    static let shared = App()
    private init() {}
    
    var userCpf       = "45124712864"

    var amountOfStars = 4 {
        didSet {
          amountOfStars = amountOfStars > 5 ? min(amountOfStars,5) : oldValue
        }
    }
    
    private var everybodyTrees:[[String:Any]]? {
        didSet {
          guard let trees = everybodyTrees,
                !trees.isEmpty else {
                everybodyTrees = nil
                self.ud.removeObject(forKey: "trees")
                return
          }

          var salved = self.ud.object(forKey: "trees") as? [String:Any] ?? [:]
          salved["trees_information"] = trees
          self.ud.set(salved, forKey: "trees")
          self.ud.synchronize()
        }
    }
    
    var amountOfTrees = 0
    
    var treesIdentifiers:[[String:Int]]? {
        didSet {
          guard let identifiers = treesIdentifiers else {
                treesIdentifiers = nil
                return
          }
            
          var number_trees:[Int] = []
          for i in identifiers {
            guard let id = i["arvore_id"] else {
                  treesIdentifiers = nil
                  return
            }
            number_trees.append(id)
          }
            
          var number_trees_salved = ud.object(forKey: "number_trees") as? [String:Any] ?? [:]
          number_trees_salved["numbers"] = number_trees
          ud.set(number_trees_salved, forKey: "number_trees")
          ud.synchronize()
        }
    }
    
    
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
        guard let treesSalved = ud.object(forKey: "trees") as? [String:Any] else {
            return nil
        }
        
        guard let informations = treesSalved["trees_information"] as? [[String:Any]] else {
            return nil
        }
        
        var treesReturn = Array<Tree>()
        for (i,t) in informations.enumerated() {
            guard let title = t["titulo"] as? String,
                  let points    = t["pontos"] as? Int,
                  let longitude = t["longitude"] as? String,
                  let latitude  = t["latitude"] as? String,
                  let degreesLongitude:CLLocationDegrees = Double(longitude),
                  let degreesLatitude:CLLocationDegrees  = Double(latitude)
                  else{
                  return nil
            }
            
            let id    = i + 1
            let location = CLLocationCoordinate2D(latitude: degreesLatitude, longitude: degreesLongitude)
            let newTree = Tree(treeId: id, treeTitle: title, treePoints: points, location: location)
            treesReturn.append(newTree)
        }
        return treesReturn
    }
    
    func saveInformationTrees() -> Void {
        guard let number_trees = ud.object(forKey: "number_trees") as? [String:Any],
              let trees = number_trees["numbers"] as? [Int] else {
              return
        }
        
        var treesForSalved:[[String:Any]] = []
        for tree in trees {
            guard let remoteURL = URL(string: "https://inovatend.mybluemix.net/imagens/arvore/\(tree)"),
                  let treeInfoData = try? Data(contentsOf: remoteURL),
                  let json = try? JSONSerialization.jsonObject(with: treeInfoData, options: JSONSerialization.ReadingOptions()),
                  let info = json as? [String:Any],
                  let tree = info["arvore"] as? [String:Any]
                  else{
                  return
            }
            
            treesForSalved.append(tree)
        }
        self.everybodyTrees = treesForSalved
    }
}
