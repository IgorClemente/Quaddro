//
//  FolderViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class FolderViewController: UIViewController {
    
    @IBOutlet weak var uiList:UITableView?
    @IBOutlet weak var uiLoadingView:UIView?
    
    // Variáveis de apoio
    var caminho:String       = ""
    var nomePasta:String     = "Início"
    var conteudos:[Conteudo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = nomePasta
        
        Derpbox.compartilhado.listarPasta(comCaminho: caminho) { (conteudos) in
            self.conteudos = conteudos
            // Pede ao tableview que atualize novamente a tabela, após baixar as pastas/arquivos
            self.uiList?.reloadData()
        }
    }
    
    var loading:Bool?  {
        didSet {
            self.uiList?.isHidden        = loading ?? false
            self.uiLoadingView?.isHidden = !(loading ?? true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading = false
    }
    
}

extension FolderViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conteudos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conteudo = conteudos[indexPath.row]     // Pegar conteudo por linha da tabela
        
        // escolhe a interface com o ícone adequado
        let nomeDaCelula = conteudo.tag == .folder ? "folder" : "file"
        
        guard let celula = tableView.dequeueReusableCell(withIdentifier: nomeDaCelula) 
            as? EntryTableViewCell else {
            fatalError("Interface não encontrada")    
        }
        
        celula.uiName?.text = conteudo.nome
        celula.uiDate?.text = conteudo.dataBonitinha ?? ""
        return celula
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        let conteudo = self.conteudos[indexPath.row] 
        if conteudo.tag == .folder {
           // Cria uma nova tela de Folder
           // Empilhar na navegação
           guard let tela = storyboard?.instantiateViewController(withIdentifier: "FolderController")
                 as? FolderViewController else {
                 return    
           }
           
           tela.caminho = conteudo.caminho
           tela.nomePasta = conteudo.caminho.components(separatedBy: "/").last ?? ""

           self.navigationController?.pushViewController(tela, animated: true)
        }else{
           let tela = VerArquivosViewController()
           tela.conteudo = conteudo
           self.present(tela, animated: true, completion: nil)
        }
    }
}
