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
        guard let id = self.marca_id,
              let tableView = self.uiVeiculosTableView else {
            return
        }
        
        AppSingleton.shared.recovery(informationFor:"/api/1/carros/veiculos/\(id).json") { (completed, informations, error) in
            guard error == nil else {
                return
            }
            
            if completed {
               guard let veiculosObject = informations else {
                   return
               }
                
               veiculosObject.forEach { (object) in
                  let newVeiculo = VeiculoModel(forJSON: object)
                  self.veiculos?.append(newVeiculo)
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
