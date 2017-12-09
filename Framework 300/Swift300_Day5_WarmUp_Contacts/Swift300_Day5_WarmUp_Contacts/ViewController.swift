//
//  ViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        todosContatos()
    }
    
    func todosContatos() {
        // Criamos uma requisicao que vai buscar nome e sobrenome
        let requisicao = CNContactFetchRequest(keysToFetch: [
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactGivenNameKey as CNKeyDescriptor
        ])
        
        // Depois de configurada a requisição, é só percorrer a lista de contatos encontrada
        try? CNContactStore().enumerateContacts(with: requisicao, usingBlock: { (contato, _) in
            print(contato.givenName,contato.familyName) 
        })
    }
}

