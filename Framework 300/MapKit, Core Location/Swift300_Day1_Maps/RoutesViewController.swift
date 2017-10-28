//
//  RoutesViewController.swift
//  Swift300_Day1_Maps
//

import UIKit
import MapKit

class RoutesViewController: UIViewController {

    @IBOutlet weak var uiTipoTransporte: UISegmentedControl?
    @IBOutlet weak var uiTabela:UITableView?
    
    var place:App.MapPlace?
    var rotas:[MKRoute] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pedirRota()
    }
    
    @IBAction func tapChangeTransportType(_ sender: Any) {
        pedirRota()
    }
    
    func pedirRota(){
        
        // Primeiro definimos o ponto de saída e chegada
        guard let saida   = app.currentUserLocation,
              let chegada = self.place?.coordinate.coordinate else {
            return
        }
        
        // é preciso transformar em PlaceMark
        let pSaida   = MKPlacemark(coordinate: saida)
        let pChegada = MKPlacemark(coordinate: chegada)
        
        // Vamos montar uma requisicao de rota
        // com saída e chegada
        
        let requisicao = MKDirectionsRequest()
        requisicao.source      = MKMapItem(placemark: pSaida)
        requisicao.destination = MKMapItem(placemark: pChegada)
        // Opcoes de rotas - solicita os tipos
        requisicao.requestsAlternateRoutes = true
        
        guard let tipo = uiTipoTransporte?.titleForSegment(at: 
              uiTipoTransporte?.selectedSegmentIndex ?? 0) else {
            return
        }
        
        switch tipo {
            case "de carro": requisicao.transportType   = .automobile
            case "caminhando": requisicao.transportType = .walking
            default: return
        }
        
        let direcoes = MKDirections(request: requisicao)
        direcoes.calculate { (resposta,erro) in
            if let todasRotas = resposta?.routes {
               self.rotas = todasRotas
               self.uiTabela?.reloadData()
            }
        }
    }

}

// Presente do lino:
// MARK: tableview delegate
extension RoutesViewController : UITableViewDelegate, UITableViewDataSource{
    
    // Entrando na próxima tela
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "rota", sender: rotas[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RouteViewController,
            let rota = sender as? MKRoute{
            controller.rota = rota
            controller.lugar = self.place
        }
    }
    
    // Respondendo cells da tabela
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rotas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rota") else{
            return UITableViewCell()
        }
        
        let umaRota = self.rotas[indexPath.row]
        
        cell.textLabel?.text       = umaRota.name
        
        // Outra solucao -> let detalhes = String(format: "%0.1f Kms, %d min.", 
        //                                          umaRota.distance/1000,
        //                                          umaRota.expectedTravelTime/60)
        
        cell.detailTextLabel?.text = "\(round(umaRota.distance/1000)) Km, \(Int(round(umaRota.expectedTravelTime/60))) min"
        
        return cell
    }
}
