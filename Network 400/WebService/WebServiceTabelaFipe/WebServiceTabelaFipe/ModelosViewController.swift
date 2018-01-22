//
//  ModelosViewController.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 21/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class ModelosViewController: UIViewController {

    @IBOutlet weak var uiModelosTableView:UITableView?
    var modelos:[ModeloModel]? = []
    var codigo_marca:Int?
    var codigo_veiculo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let codigo_marca   = self.codigo_marca,
              let codigo_veiculo = self.codigo_veiculo else {
            return
        }
        self.recovery(modelosFor: "/api/1/carros/veiculo/\(codigo_marca)/\(codigo_veiculo).json")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recovery(modelosFor endPoint:String) {
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        
        guard let url = URL(string: uri),
              let tableView = self.uiModelosTableView else {
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
                
                  jsonObject.forEach { (modelo) in
                      let newModelo = ModeloModel(forJSON: modelo)
                      self.modelos?.append(newModelo)
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

extension ModelosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let modelos = self.modelos else {
            return 0
        }
        return modelos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "modelo"),
              let modelos = self.modelos else {
            return UITableViewCell()
        }
        
        let index  = indexPath.row
        let modelo = modelos[index]
        
        cell.textLabel?.text = modelo.name
        return cell
    }
}
