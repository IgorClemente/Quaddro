//
//  MarcasViewController.swift
//  WebServiceTabelaFipe
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class MarcasViewController: UIViewController {

    @IBOutlet weak var uiMarcasTableView:UITableView?
    var marcas:[Marca]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recovery(marcasFor: "/api/1/carros/marcas.json")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recovery(marcasFor endPoint:String) {
        
        let uri = "https://fipeapi.appspot.com\(endPoint)"
        
        guard let url = URL(string: uri),
              let marcaTableView = self.uiMarcasTableView else {
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
                
                  jsonObject.forEach { (marca) in
                      let newMarca = Marca(forJSON: marca)
                      self.marcas?.append(newMarca)
                  }
                
                  DispatchQueue.main.async {
                     marcaTableView.reloadData()
                  }
            
               } catch let erro {
                 print("Error parse \(erro.localizedDescription)")
               }
            }
        }
        
        task.resume()
    }
}

extension MarcasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let marcas = self.marcas else {
            return 0
        }
        return marcas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell   = tableView.dequeueReusableCell(withIdentifier: "marca"),
              let marcas = self.marcas else {
            return UITableViewCell()
        }
        
        let marca = marcas[indexPath.row]
    
        cell.textLabel?.text = marca.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let marcas = self.marcas else {
            return
        }
        
        let rowSelected   = indexPath.row
        let marcaSelected = marcas[rowSelected]
        performSegue(withIdentifier: "veiculos", sender: marcaSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? VeiculosViewController,
              let marca       = sender as? Marca,
              let idMarca     = marca.id else {
            return
        }
        destination.idMarca = idMarca
    }
}

