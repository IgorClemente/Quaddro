//
//  AjustesViewController.swift
//  Swift200_Day8_TableStack
//
//  Created by Swift on 30/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class AjustesViewController: UIViewController,UITableViewDataSource,
                             UITableViewDelegate {
    
    @IBOutlet weak var uiTabela: UITableView?
    var sections = ["Cidades","Celsius"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
            case "Cidades":
                return App.compartilhado.cidades.count 
            case "Celsius":
                return 1 
            default:
                break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celulaCidade = tableView.dequeueReusableCell(withIdentifier: "cellCidade"),
              let celulaCelsius = tableView.dequeueReusableCell(withIdentifier: "cellGraus") else {
            fatalError("Ops! o nome tá errado !")
        }
        
        let numLinha = indexPath.row    // Extraindo o numero da linha
        
        switch sections[indexPath.section] {
            case "Cidades":
                celulaCidade.textLabel?.text = App.compartilhado.cidades[numLinha].nome
                return celulaCidade
            case "Celsius":
                celulaCelsius.textLabel?.text = "Celsius ?"
                let botao = UISwitch()
                botao.isOn = App.compartilhado.usarCelsius
                botao.onTintColor = UIColor.orange
                botao.addTarget(self, action: #selector(trocaCelcius(sender:)), for: .touchUpInside)
                celulaCelsius.accessoryView = botao
                return celulaCelsius
            default:
                break
        }        
        return UITableViewCell() 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func trocaCelcius(sender:UISwitch) {
        App.compartilhado.usarCelsius = sender.isOn
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = uiTabela?.cellForRow(at: indexPath) else {
            return
        }
        // Marca com Checkmark
        celula.accessoryType = .checkmark
        
        // Salvamos a nova favorita
        App.compartilhado.salvarFavorita(comNome: celula.textLabel?.text ?? "")
    }
    
    // Quando desmarcar a celula, alteramos
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let celula = uiTabela?.cellForRow(at: indexPath) else {
            return
        }
        celula.accessoryType = .none
    }
    
    // Vou selecionar um celula
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            return nil 
        }
        return indexPath
    }
    
    func atualizaSelecao() {
        
        let cidadeFavorita = App.compartilhado.favorita 
        let cidades    = App.compartilhado.cidades
        
        for (indice,cidade) in cidades.enumerated() {
            if cidade.nome == cidadeFavorita {
                let idxPath = IndexPath.init(row: indice, section: 0)
                uiTabela?.selectRow(at: idxPath, animated: true, scrollPosition: .none)
                uiTabela?.cellForRow(at: idxPath)?.accessoryType = .checkmark
            }
        }
    }
    
    // Alterando a cor da navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barStyle = .default
        
        self.atualizaSelecao()
    }
            
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barStyle = .black
    }
}
