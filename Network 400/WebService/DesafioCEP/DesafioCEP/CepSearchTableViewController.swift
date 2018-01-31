//
//  CepSearchTableViewController.swift
//  DesafioCEP
//
//  Created by Swift on 27/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

/*
 
 {
 "cep": "04864-190",
 "logradouro": "Acesso Pardal Cinza",
 "complemento": "",
 "bairro": "Balneário São José",
 "localidade": "São Paulo",
 "uf": "SP",
 "unidade": "",
 "ibge": "3550308",
 "gia": "1004"
 }
 
 */

import UIKit

class CepSearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var uiLogradouroTextLabel:UILabel?
    @IBOutlet weak var uiComplementoTextLabel:UILabel?
    @IBOutlet weak var uiBairroTextLabel:UILabel?
    @IBOutlet weak var uiLocalidadeTextLabel:UILabel?
    @IBOutlet weak var uiUfTextLabel:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBarCep      = UISearchBar()
        searchBarCep.autocapitalizationType = .sentences
        searchBarCep.delegate = self
        searchBarCep.becomeFirstResponder()
        
        navigationItem.titleView = searchBarCep
    }
    
    func search(cep: String) -> Void {
        guard let logradouroText  = self.uiLogradouroTextLabel,
              let complementoText = self.uiComplementoTextLabel,
              let localidadeText  = self.uiLocalidadeTextLabel,
              let ufText          = self.uiUfTextLabel,
              let bairroText      = self.uiBairroTextLabel else {
            return
        }

        Cep.recovery(informationFor: cep) { (completed, information) in
            if completed {
                guard let cepInformation = information else {
                    return
                }
                
                logradouroText.text  = cepInformation.logradouro
                complementoText.text = cepInformation.complemento
                localidadeText.text  = cepInformation.localidade
                ufText.text          = cepInformation.uf
                bairroText.text      = cepInformation.bairro
             }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              text.contains("-") else {
            let alertError = UIAlertController(title: "Formato Inválido",
                                               message: "O formato para o CEP digitado está incorreto, entre com um formato válido para continuar",
                                               preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Entendi",
                                            style: .default,
                                            handler: nil)
            alertError.addAction(alertAction)
            
            self.present(alertError, animated: true, completion: nil)
            return
        }
        
        self.search(cep: text)
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
