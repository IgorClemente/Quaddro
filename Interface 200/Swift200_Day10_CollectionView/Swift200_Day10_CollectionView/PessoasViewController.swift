//
//  PessoasViewController.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class PessoasViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var uiTabela: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Num. de pessoas:",PeopleStorage.shared.everybody.count)
        
        // Toda vez que eu entrar na tela
        // Quero reprocessar a tabela
        uiTabela?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PeopleStorage.shared.kinds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let kinds = PeopleStorage.shared.kinds
        return PeopleStorage.shared.everybody(ofKind: kinds[section]).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let kinds = PeopleStorage.shared.kinds
        
        switch kinds[section] {
            case .family:
                return "Minha Familia"
            case .friends:
                return "Amigos"
            case .work:
                return "Trabalho"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let celulaPeople = tableView.dequeueReusableCell(withIdentifier: "pessoa") as? PessoaTableViewCell else {
            return UITableViewCell()
        }
        
        let kinds            = PeopleStorage.shared.kinds
        let peoplesOfSection = PeopleStorage.shared.everybody(ofKind: kinds[indexPath.section])
        let person           = peoplesOfSection[indexPath.row]
        
        if let dataImagem = try? Data(contentsOf: person.pic) {
            celulaPeople.uiFotinho?.image  = UIImage(data: dataImagem)
            celulaPeople.uiNome?.text      = person.name
        
            switch kinds[indexPath.section].rawValue {
            case "family":
                return celulaPeople
            case "work":
                return celulaPeople
            case "friends":
                return celulaPeople
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
