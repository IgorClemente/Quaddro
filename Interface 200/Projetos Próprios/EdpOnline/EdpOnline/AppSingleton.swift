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

    var currentLocation:CLLocationCoordinate2D? = nil
    private var ud  = UserDefaults.standard
    
    var amountOfTrees = 0
    var userCpf = "45124712864"
    var trees_numbers:[Int]? = nil {
        didSet {
            guard let numbers = trees_numbers else {
                return
            }
            
            let reverse_numbers = numbers.reversed().map {
                return $0
            }
            trees_numbers = reverse_numbers
        }
    }

    var amountOfStars = 3 {
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
          self.trees_numbers = number_trees
            
          var number_trees_salved = ud.object(forKey: "number_trees") as? [String:Any] ?? [:]
          number_trees_salved["numbers"] = number_trees
          ud.set(number_trees_salved, forKey: "number_trees")
          ud.synchronize()
        }
    }
    
    private var userLogged:[String:Any]? {
        get {
            guard let salved = ud.object(forKey: "logged_information") as? [String:Any],
                  let info   = salved["information"] as? [String:Any] else {
                  return nil
            }
            return info
        }
        
        set {
            var salved = ud.object(forKey: "logged_information") as? [String:Any] ?? [:]
            salved["information"] = newValue
            ud.set(salved, forKey: "logged_information")
            ud.synchronize()
        }
    }
    
    func saveUser(_ completation:(Bool)->()) -> Void {
        let end_point = "https://inovatend.mybluemix.net/users/\(self.userCpf)"
        
        guard let remoteURL = URL(string: end_point) else {
              completation(false)
              return
        }
        
        do {
            let data     = try Data(contentsOf: remoteURL)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            
            guard let jsonObject = jsonData as? [String:Any],
                  let info       = jsonObject["usuario"] as? [[String:Any]],
                  let user_info  = info.first,
                  let trees_id   = jsonObject["arvore_ids"] as? [[String:Int]],
                  let trees      = jsonObject["arvores"] as? [String:Any],
                  let trees_amount = trees["quantidade"] as? Int,
                  let user       = User(forInformation: user_info) else {
                  completation(false)
                  return
            }
            
            self.userLogged       = user_info
            self.treesIdentifiers = trees_id
            self.amountOfTrees    = trees_amount
            completation(true)
        }catch{
            completation(false)
            print("ERROR", error.localizedDescription)
        }
    }
    
    func getUserLogged(_ completation:(User?)->()) -> Void {
        guard let user_information = self.userLogged,
              let user = User(forInformation: user_information) else {
              completation(nil)
              return
        }
        
        completation(user)
        return
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
