//
//  VeiculosViewController.swift
//  WebServiceTabelaFipe
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class VeiculosViewController: UIViewController {

    @IBOutlet weak var uiVeiculosTableView:UITableView?
    var marca_id:Int?        = nil
    var veiculos:[VeiculoModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = self.marca_id else {
            return
        }
        self.recovery(veiculosFor: "/api/1/carros/veiculos/\(id).json")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recovery(veiculosFor endPoint:String) {
        
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        guard let url = URL(string: uri),
              let tableView = self.uiVeiculosTableView  else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task    = session.dataTask(with: url) { (data, response, error) in
            if let erro = error {
               let alertError = UIAlertController(title: "Aconteceu um erro", message: erro.localizedDescription, preferredStyle: .alert)
               let alertErrorAction = UIAlertAction(title: "Entendi", style: .default, handler: nil)
               alertError.addAction(alertErrorAction)
                
               self.present(alertError, animated: true, completion: nil)
            }
            
            if let dataReceive = data {
               do {
                  guard let jsonObject = try JSONSerialization.jsonObject(with: dataReceive, options: JSONSerialization.ReadingOptions()) as? [[String:Any]] else {
                      return
                  }
                
                  jsonObject.forEach { (veiculo) in
                      let newVeiculo = VeiculoModel(forJSON: veiculo)
                      self.veiculos?.append(newVeiculo)
                  }
                
                  DispatchQueue.main.async {
                      tableView.reloadData()
                  }
               } catch let erro {
                    print("Error parse \(erro.localizedDescription)")
               }
            }
        }
        task.resume()
    }
}


extension VeiculosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let veiculos = self.veiculos else {
            return 0
        }
        return veiculos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell     = tableView.dequeueReusableCell(withIdentifier: "veiculo"),
              let veiculos = self.veiculos else {
            return UITableViewCell()
        }
        
        let index   = indexPath.row
        let veiculo = veiculos[index]
        cell.textLabel?.text = veiculo.fipe_name 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let veiculos     = self.veiculos,
              let codigo_marca = self.marca_id else {
            return
        }
        
        let index   = indexPath.row
        let veiculo = veiculos[index]
        
        if let veiculo_id = veiculo.id {
           let dictionaryInfos = ["codigo_marca": codigo_marca,"codigo_veiculo": veiculo_id] as [String : Any]
           performSegue(withIdentifier: "modelo", sender: dictionaryInfos)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination  = segue.destination as? ModelosViewController,
              let informations = sender as? [String:Any],
              let codigo_marca = informations["codigo_marca"] as? Int,
              let codigo_veiculo = informations["codigo_veiculo"] as? String else {
            return
        }
        
        destination.codigo_marca = codigo_marca
        destination.codigo_veiculo = codigo_veiculo
    }
}
