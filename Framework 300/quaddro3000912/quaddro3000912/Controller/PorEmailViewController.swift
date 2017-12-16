//
//  PorEmailViewController.swift
//  quaddro3000912
//
//  Created by Swift on 09/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import Contacts
import MessageUI

class PorEmailViewController : UIViewController, UITextFieldDelegate,
                               UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var uiTableViewContatos: UITableView?
    var contatosFiltrados:[CNContact] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contatosFiltrados = todosOsContatos() ?? []
        self.uiTableViewContatos?.reloadData()
    }
    
    func todosOsContatos() -> [CNContact]? {
        var contatos:[CNContact] = []
        let request = CNContactFetchRequest(keysToFetch: [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ])
        
        try? CNContactStore().enumerateContacts(with: request, usingBlock: { (contato, _) in
            contatos.append(contato)
        })
        return contatos
    }
    
    func filtrarPor(nome: String) {
        guard let contatos = self.todosOsContatos() else {
            return
        }
        
        self.contatosFiltrados = contatos.filter{ $0.givenName.contains(nome) }
        if nome == "" { 
           self.contatosFiltrados = contatos 
        }
        self.uiTableViewContatos?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatosFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula   = tableView.dequeueReusableCell(withIdentifier: "contato") as? PessoaTableViewCell else {
            return UITableViewCell()
        }
        
        let contatos = self.contatosFiltrados
        celula.nome?.text      = contatos[indexPath.row].givenName
        celula.sobrenome?.text = contatos[indexPath.row].familyName  
        
        return celula
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Range do texto sendo alterado
        let old     = (textField.text as NSString?) ?? ""
        let newText = old.replacingCharacters(in: range, with: string)
        self.filtrarPor(nome: newText)
        return true
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uiTapEnviarEmail() {
        guard let linhaSelecionada = uiTableViewContatos?.indexPathForSelectedRow?.row else {
              return   
        }
        
        let contato = self.contatosFiltrados[linhaSelecionada]
        
        if MFMailComposeViewController.canSendMail() {
            let tela = MFMailComposeViewController()
            tela.setMessageBody("Olá, Segue contato \(contato.givenName)", isHTML: true)
            tela.setSubject("Envio de contato")
            tela.mailComposeDelegate = self 
            self.present(tela, animated: true, completion: nil)
        }
    }
}
