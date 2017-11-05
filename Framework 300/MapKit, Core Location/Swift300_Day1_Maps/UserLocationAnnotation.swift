//
//  UserLocationAnnotation.swift
//  Swift300_Day1_Maps
//

import UIKit
import MapKit


class UserAnnotation : NSObject, MKAnnotation {

    let localUser:CLLocationCoordinate2D
    let identifier = "user"
    
    
    init(paraLocalUser local:CLLocationCoordinate2D) {
        localUser = local 
    }
    
    var coordinate: CLLocationCoordinate2D {
        return self.localUser
    }
    
    var title: String? {
        return nil
    }
    
    var subtitle: String? {
        return nil
    }

    func viewUserAnnotation() -> MKAnnotationView {
        
        let view   = MKAnnotationView(annotation: self, reuseIdentifier: self.identifier)
        view.image = UIImage(named: self.identifier)
        view.canShowCallout = false
        return view
    }
}
