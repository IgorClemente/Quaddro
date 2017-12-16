//
//  MandaAeViewController.swift
//  quaddro3000912
//
//  Created by Swift on 09/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import Contacts
import MessageUI


class MandaAeViewController : UIViewController, UITableViewDataSource,
                              UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var uiTableContatos: UITableView?
    @IBOutlet weak var uiTableDestinos: UITableView?
    
    var contatoSelecionado:[Int:UITableView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTableContatos?.reloadData()
        uiTableDestinos?.reloadData()
    }
    
    func todosContatos() -> [CNContact]? {
        var contatos:[CNContact] = []
        
        let requisicao = CNContactFetchRequest(keysToFetch: [
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ])
        
        try? CNContactStore().enumerateContacts(with: requisicao, usingBlock: { (contato, _) in
             contatos.append(contato)
        })
        return contatos
    }
    
    @IBAction func uiTapEnviarMensagem() {
        guard let tabelaContatos = self.uiTableContatos,
              let tabelaDestinos = self.uiTableDestinos else {
              return   
        }
        
        guard let contatos = todosContatos(),
              let emissor  = tabelaContatos.indexPathForSelectedRow?.row,
              let receptor = tabelaDestinos.indexPathForSelectedRow?.row,
              emissor != receptor else {
              return
        }
        
        guard let numeroContato  = contatos[emissor].phoneNumbers.first?.value.stringValue,
              let numeroReceptor = contatos[receptor].phoneNumbers.first?.value.stringValue else {
              return  
        } 
        let nomeContato    = contatos[emissor].givenName 
        
        if MFMessageComposeViewController.canSendText() {
            let tela  = MFMessageComposeViewController()
            tela.body = "Segue contato :\n\(nomeContato)\n\(numeroContato)" 
            tela.recipients = [numeroReceptor]
            tela.messageComposeDelegate = self 
            self.present(tela, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contatos = todosContatos() else {
              return 0
        }
        return contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identificador = "contato"
        
        if let tabela    = self.contatoSelecionado[indexPath.row] {
           identificador = tabela != tableView ? "contato-disabled" : "contato" 
        }
        
        guard let celula   = tableView.dequeueReusableCell(withIdentifier: identificador) as? PessoaTableViewCell,
              let contatos = todosContatos() else {
              return UITableViewCell()
        }

        celula.nome?.text      = contatos[indexPath.row].givenName
        celula.sobrenome?.text = contatos[indexPath.row].familyName
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tabela = self.contatoSelecionado[indexPath.row] {
           let linhaSelecionada = tabela.indexPathForSelectedRow 
           tabela.reloadData()
           tabela.selectRow(at: linhaSelecionada, animated: true, scrollPosition: .none) 
        }else{
           self.contatoSelecionado[indexPath.row] = tableView
           self.uiTableContatos?.reloadData()
           self.uiTableDestinos?.reloadData()  
        }
    } 
}
