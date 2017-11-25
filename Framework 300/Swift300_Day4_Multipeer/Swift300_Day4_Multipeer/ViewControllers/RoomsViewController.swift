//
//  RoomsViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController {
    
    @IBOutlet weak var uiTable:UITableView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO-6
        NotificationCenter.default.addObserver(forName: 
            NSNotification.Name("lista-mudou"), object: nil, queue:
            OperationQueue.main) { _ in
                // Explicacao: toda vez que a lista de pessoas mudar
                // atualiza a tabela, assim some gente, vem gente.
                self.uiTable?.reloadData()
        }
        
        app.conectarTudo()
        self.uiTable?.reloadData()
    }
}

extension RoomsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Uma sessão, com a lista de Bros
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Quantidade de itens = quantidade de bros conectados
        return app.connectedBros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cria uma celula para colocar as informações do bro
        // basicamente um fundo colorido, com um emoji
        // o nick e também a última mensagem (se houver)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "bro") as? BroTableViewCell else{
            fatalError()
        }
        
        let bro = app.connectedBros[indexPath.row]
        cell.uiNameLabel?.text  = bro.nick
        cell.uiEmojiLabel?.text = bro.emoji
        cell.uiEmojiBG?.changeColor(withSeed: bro.tag)
        
        if let last = app.messages(from: bro).last {
            var text = last.isMe ? "eu: " : ""
            text += last.text
            cell.uiLastMessageLabel?.text = text
        }else{
            cell.uiLastMessageLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Quando escolher um, vai para tela de chat
        // mas antes passa o bro via sender para tela
        let bro = app.connectedBros[indexPath.row]
        performSegue(withIdentifier: "goToRoom", sender: bro)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // recebe aqui o bro vindo do performSegue e repassa
        // certinho para próxima tela
        guard let controller = segue.destination as? RoomViewController,
              let bro = sender as? App.BroInfo else{
            return
        }
        
        controller.bro = bro
    }
    
}
