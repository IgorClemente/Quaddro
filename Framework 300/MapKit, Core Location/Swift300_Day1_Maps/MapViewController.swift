//
//  MapViewController.swift
//  Swift300_Day1_Maps
//
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: outlets
    @IBOutlet weak var uiBottomMenuGuide: NSLayoutConstraint?
    @IBOutlet weak var uiAddressTextfield: UITextField?
    @IBOutlet weak var uiMapa: MKMapView?
    
    let gestorDeLocalizacao = CLLocationManager() // Captura lat/long do device
    let geocodificador      = CLGeocoder()   // lat, long -> Rua, numero, e vice-versa
    
    
    @IBAction func changeMapType(sender:UISegmentedControl) {
        
        guard let tipoSelecionado = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            fatalError("Voce nao ligou algum outlet.")
        }
        
        switch tipoSelecionado {
            
            case "Satélite": uiMapa?.mapType = .satellite
            case "Híbrido" : uiMapa?.mapType = .hybrid
            default: uiMapa?.mapType = .standard
        }
    }
    
    func buscarPelaLocalização(){
        
        // Mas sera que podemos?
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            
            pedirAutorizacaoDoUsuario()
        
        case .authorizedAlways, .authorizedWhenInUse:
            gestorDeLocalizacao.delegate = self
            gestorDeLocalizacao.desiredAccuracy = kCLLocationAccuracyKilometer
            gestorDeLocalizacao.startUpdatingLocation()
        
        default:
            break;
        }
    }
    
    // Opa! usuário escolheu alguma coisa sobre localizacao
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.buscarPelaLocalização()

        default:
            break
        }    
    }
    
    // Recebendo a latitude e longitude do usuário
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let ultimaLocalizacao = locations.last else {
            return
        }
        // Isso economiza bateria !
        gestorDeLocalizacao.stopUpdatingLocation()
        
        geocodificador.reverseGeocodeLocation(ultimaLocalizacao) { 
            (lugares, erro) in
            if let lugarMaisInteressante = lugares?.first {
                self.atualizarMapa(comPlaceMark: lugarMaisInteressante)
            }
        }
    }
    
    
    func buscar(endereçoDigitado endereço:String){
        geocodificador.geocodeAddressString(endereço) { (lugares, erro) in
            if let lugarMaisProvavel = lugares?.first {
                // atualizar o mapa com o lugar
                self.atualizarMapa(comPlaceMark: lugarMaisProvavel)
            }
        }
    }
    
    func atualizarMapa(comPlaceMark endereço:CLPlacemark) {
        
        // Recuperando last/long do endereço geocodificando
        guard let localizacao = endereço.location else {
            fatalError("Não sei onde é mais sei :B")
        }
        
        // Atualizando interface e backend sobre a localizacao
        // do usuario
        self.uiAddressTextfield?.text = endereço.name
        app.currentUserLocation = localizacao.coordinate
        
        // Centralizando o mapa num lugar
        // -> Centro = localizacao.coordinate (lat/long)
        // -> tamanho = span (+ ou - 1km)
        let tamanhoDaRegiao = MKCoordinateSpanMake(0.01, 0.01)
        let regiao          = MKCoordinateRegion(center: localizacao.coordinate, span: tamanhoDaRegiao)
        
        self.atualizarPins()
        uiMapa?.setRegion(regiao, animated: true)
    }
    
    func atualizarPins() {
        
        // Antes de colocar novos, remove qualquer
        // anterior que já esteja ali
        
        uiMapa?.removeAnnotations(uiMapa?.annotations ?? [])
        
        if let localUser = app.currentUserLocation {
            
            let pinUser = UserAnnotation(paraLocalUser: localUser)
            uiMapa?.addAnnotation(pinUser)
        }
        
        // para cada farmacia
        for farmacia in app.mapPlaces {
            let pin        = FamarciaAnnotation(noLugar: farmacia)
            uiMapa?.addAnnotation(pin)
        }
    }
    
    // Precisamos de autorizacao para acessar
    // onde as pessoas está
    func pedirAutorizacaoDoUsuario() {
        if CLLocationManager.locationServicesEnabled() {
            gestorDeLocalizacao.delegate = self
            // Queremos localizacao apenas quando o APP está aberto
            // Gasta menos bateria
            gestorDeLocalizacao.requestWhenInUseAuthorization()
        }
    }
}


extension MapViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let lugar = annotation as? FamarciaAnnotation {
            return uiMapa?.dequeueReusableAnnotationView(withIdentifier: lugar.identifier) ?? lugar.viewDaAnnotation()
        }else {
          if let user_pin = annotation as? UserAnnotation {
            return user_pin.viewUserAnnotation()
          }else {
            return nil    
          }
        } 
    }
    
    // Quando o usuário da um tap no botao do callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // qual fármacia que foi ?
        if let farmacia = view.annotation as? FamarciaAnnotation {
            self.performSegue(withIdentifier: "rotas", sender: farmacia.lugar)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let telaRotas = segue.destination as? RoutesViewController,
           let farmacia  = sender as? App.MapPlace {
            
            telaRotas.place = farmacia
        }
    }
}

// Presente do lino:
// MARK: Implementações de UI

extension MapViewController{
    
    // MARK: menu sobe e desce
    @IBAction func tapDetails(sender:UIButton) {
        
        let transform       = sender.transform
        let currentRotation = atan2(transform.b, transform.a)
        
        UIView.animate(withDuration: 0.32) {
            
            if currentRotation == 0 {
                self.uiBottomMenuGuide?.constant = 0
                sender.transform = CGAffineTransform(rotationAngle: 3.14)
            }else {
                self.uiBottomMenuGuide?.constant = -60
                sender.transform = CGAffineTransform(rotationAngle: 0)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func tapSearchUserByTextInput(){
        buscar(endereçoDigitado:uiAddressTextfield?.text ?? "")
        uiAddressTextfield?.resignFirstResponder()
    }
    
    @IBAction func tapSearchUserByLocation(){
        self.buscarPelaLocalização()
    }
}

extension MapViewController : UITextFieldDelegate {
    
    // MARK: botão search do teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        buscar(endereçoDigitado: textField.text ?? "")
        return false
    }
}
 
