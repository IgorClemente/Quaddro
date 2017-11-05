//
//  RouteViewController.swift
//  Swift300_Day1_Maps
//

import UIKit
import MapKit

class RouteViewController: UIViewController {

    @IBOutlet weak var uiTabela:UITableView?
    @IBOutlet weak var uiMap:MKMapView?

    var rota:MKRoute?
    var lugar:App.MapPlace?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let localUser = app.currentUserLocation {
           let pinUser = UserAnnotation(paraLocalUser: localUser)
            uiMap?.addAnnotation(pinUser)
        }
        
        let farmacias = app.mapPlaces
        for famarcia in farmacias {
            if famarcia.name == lugar?.name {
               let pin = FamarciaAnnotation(noLugar: famarcia)
               uiMap?.addAnnotation(pin) 
            }
        }
        
        // Desenho da rota
        for step in rota?.steps ?? [] {
            uiMap?.add(step.polyline,level:.aboveRoads)
        }
        
        uiMap?.showAnnotations(uiMap?.annotations ?? [], animated: true)
    }
    
}


// Presente do lino:
// MARK: TableView delegate & datasource
extension RouteViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rota?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rota"),
              let instrucoesRota = rota?.steps else{
            return UITableViewCell()
        }
    
        cell.textLabel?.text       = instrucoesRota[indexPath.row].instructions
        cell.detailTextLabel?.text = "em \(instrucoesRota[indexPath.row].distance) metros"
        
        return cell
    }
    
}

// Ops.. calma, vai dar tudo certo! \o/
// MARK : mapview delegate
extension RouteViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let lugar = annotation as? UserAnnotation {
            return lugar.viewUserAnnotation()
        }else {
            if let farmacia = annotation as? FamarciaAnnotation {
                return farmacia.viewDaAnnotation()
            }else {
                return nil
            }
        }
    }
    
    func mapView(_ mapView: MKMapView , rendererFor overlay: MKOverlay) ->
        MKOverlayRenderer {
            
            // se estiver querendo desenhar uma linha
            // vamos fazer um novo redenrer com 5px, azul
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth   = 5.0
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)    
    } 
}
