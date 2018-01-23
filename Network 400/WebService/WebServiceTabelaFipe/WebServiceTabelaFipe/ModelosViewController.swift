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
              let codigo_veiculo = self.codigo_veiculo,
              let tableView      = self.uiModelosTableView else {
            return
        }
        
        AppSingleton.shared.recovery(informationFor: "/api/1/carros/veiculo/\(codigo_marca)/\(codigo_veiculo).json") { (completed, informations, error) in
            guard error == nil else {
                return
            }
            
            if completed {
               guard let modelosObject = informations else {
                   return
               }
               
               modelosObject.forEach { (object) in
                   let newModelo = ModeloModel(forJSON: object)
                   self.modelos?.append(newModelo)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let index = indexPath.row
        guard let codigo_marca   = self.codigo_marca,
              let codigo_veiculo = self.codigo_veiculo,
              let modelos        = self.modelos else {
            return
        }
        
        let modelo = modelos[index]
        let veiculo_informations = ["codigo_marca": codigo_marca,"codigo_veiculo": codigo_veiculo,"codigo_ano": modelo.key] as? [String:Any]
        performSegue(withIdentifier: "veiculoFipe", sender: veiculo_informations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? VeiculoInformationViewController,
              let information = sender as? [String:Any] else {
            return
        }
        
        print(information)
        destination.veiculo_information = information
    }
}
