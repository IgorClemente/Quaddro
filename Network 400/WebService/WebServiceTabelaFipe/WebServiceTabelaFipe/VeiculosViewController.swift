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
    var idMarca:Int?        = nil
    var veiculos:[Veiculo]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = self.idMarca else {
            return
        }
        self.recovery(veiculosFor: "/api/1/carros/veiculos/\(id).json")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recovery(veiculosFor endPoint:String) {
        
        let uri = "https://fipeapi.appspot.com"
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
                      let newVeiculo = Veiculo(forJSON: veiculo)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "veiculo") else {
            
        }
    }
}
