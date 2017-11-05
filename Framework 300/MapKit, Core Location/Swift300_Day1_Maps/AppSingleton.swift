//
//  AppSingleton.swift
//  Swift300_Day1_Maps
//

import Foundation
import UIKit
import CoreLocation

var app:App {
    return App.singleton
}

class App {
    
    static let singleton = App()
    
    // MARK: Informações entre telas
    var currentUserLocation:CLLocationCoordinate2D? = nil
    
    // MARK: Dados das farmácias
    var mapPlaces:[MapPlace] = []
    
    /** Estrutura que armazena as informações e um lugar */
    struct MapPlace{
        let coordinate:CLLocation
        let street:String
        let name:String
    }
    
    /** Busca o json com todas farmácias registradas e transforma
        num vetor de objetos nativos com os campos necessário */
    func loadGeolocationData(callback:(Bool)->()){
        
        guard let jsonPath = Bundle.main.url(forResource: "data", withExtension: "json"),
              let jsondata = try? Data(contentsOf: jsonPath),
              let jsonObject = try? JSONSerialization.jsonObject(
                with: jsondata,
                options: JSONSerialization.ReadingOptions()),
              let json = jsonObject as? [String:Any?],
              let results = json["results"] as? [Any] else{
            print("Ops! data.json não encontrado ou inválido! verifique se ele foi adicionado ao projeto")
            callback(false)
            return
        }
        
        var newPlaces:[MapPlace] = []
        for result in results{
            
            guard let placeData = result as? [String:Any],
                  let name      = placeData["name"] as? String,
                  let geometry  = (placeData["geometry"] as? [String:Any])?["location"] as? [String:Any],
                  let lat    = geometry["lat"] as? Double,
                  let long   = geometry["lng"] as? Double,
                  let street = placeData["vicinity"] as? String else{
                continue
            }
            
            let location = CLLocation(latitude: lat, longitude: long)
            newPlaces.append(MapPlace(coordinate: location,
                                      street: street.components(separatedBy: "-").first ?? "",
                                      name: name))
        }
        
        mapPlaces = newPlaces
        callback(true)
    }
    
}
