//
//  MapPlaceAnnotation.swift
//  Swift300_Day1_Maps
//
//

import UIKit
import MapKit


class FamarciaAnnotation : NSObject, MKAnnotation {

    let lugar:App.MapPlace
    let identifier = "place_pin"
    
    var coordinate: CLLocationCoordinate2D {
        return lugar.coordinate.coordinate
    }
    
    var title: String? {
        return lugar.name
    }
    
    var subtitle : String? {
        return lugar.street
    }
    
    init(noLugar lugar:App.MapPlace) {
        self.lugar = lugar
    }
    
    func viewDaAnnotation() -> MKAnnotationView {
        
        let view   = MKAnnotationView(annotation: self,
                                      reuseIdentifier: self.identifier)
        
        // Imagem do pin da farmácia é definida aqui
        view.image = UIImage(named:self.identifier)
        
        // Queremos mostrar balaozinho quando
        // houver um tap no pin
        view.canShowCallout = true
        
        let botaoRota   = UIButton(type: .custom)
        botaoRota.setImage(UIImage(named:"route_btn"), for: .normal)
        botaoRota.frame =  CGRect(x: 0, y: 0, width: 30, height: 30)
        view.rightCalloutAccessoryView = botaoRota
        
        return view
    }
}
