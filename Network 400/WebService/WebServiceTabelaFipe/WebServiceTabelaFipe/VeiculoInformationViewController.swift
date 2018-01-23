//
//  VeiculoInformationViewController.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 21/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class VeiculoInformationViewController: UIViewController {

    @IBOutlet weak var uiVeiculoDetailTableView:UITableView?
    private var veiculoDetailInformation:VeiculoInformationModel?
    var veiculo_information:[String:Any]? = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tableView   = self.uiVeiculoDetailTableView,
              let information = veiculo_information,
              let codigo_marca   = information["codigo_marca"] as? Int,
              let codigo_veiculo = information["codigo_veiculo"] as? String,
              let codigo_ano     = information["codigo_ano"] as? String else {
            return
        }
        
        self.recovery(informationFor: "/api/1/carros/veiculo/\(codigo_marca)/\(codigo_veiculo)/\(codigo_ano).json") { (completed, informations) in
            if completed {
               guard let information = informations else {
                   return
               }

               let newDetail = VeiculoInformationModel(forJSON: information)
               self.veiculoDetailInformation = newDetail
               DispatchQueue.main.async {
                  tableView.reloadData()
               }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recovery(informationFor endPoint: String, completation:@escaping (Bool,[String:Any]?)->()) {
        
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        guard let url = URL(string: uri) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task    = session.dataTask(with: url) { (data, response, error) in
            if let erro = error {
               let alertError = UIAlertController(title: "Aconteceu um erro", message: erro.localizedDescription, preferredStyle: .alert)
               let alertErrorAction = UIAlertAction(title: "Entendi", style: .default, handler: nil)
               alertError.addAction(alertErrorAction)
               
               self.present(alertError, animated: true, completion: nil)
               completation(false,nil)
            }
            
            if let dataReceive = data {
               do {
                 guard let jsonObject = try JSONSerialization.jsonObject(with: dataReceive, options: JSONSerialization.ReadingOptions()) as? [String:Any] else {
                     return
                 }
                 completation(true,jsonObject)
               } catch let erro {
                 print("Error parse \(erro.localizedDescription)")
                 completation(false,nil)
               }
            }
        }
        task.resume()
    }
}


extension VeiculoInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "veiculoDetail") as? VeiculoDetailTableViewCell,
              let veiculoInformation = self.veiculoDetailInformation else {
            return VeiculoDetailTableViewCell()
        }
        
        cell.title?.text     = veiculoInformation.veiculo
        cell.yearModel?.text = veiculoInformation.ano_modelo
        cell.fuel?.text      = veiculoInformation.combustivel
        cell.price?.text     = veiculoInformation.preco
        return cell
    }
}
