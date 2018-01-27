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
    var marcas:[MarcaModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tableView = self.uiMarcasTableView else {
            return
        }
        
        AppSingleton.shared.recovery(informationFor: "/api/1/carros/marcas.json") { (completed,information,error) in
            guard error == nil else {
                return
            }
            
            if completed {
               guard let marcasObject = information else {
                   return
               }
               
               marcasObject.forEach { (object) in
                   let newMarca = MarcaModel(forJSON: object)
                   self.marcas?.append(newMarca)
               }
               
               DispatchQueue.main.async {
                   tableView.reloadData()
               }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
              let marca    = sender as? MarcaModel,
              let marca_id = marca.id else {
            return
        }
        destination.marca_id = marca_id
    }
}

