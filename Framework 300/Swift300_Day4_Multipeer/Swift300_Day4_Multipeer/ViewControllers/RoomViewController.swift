//
//  RoomViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    @IBOutlet weak var uiList:UITableView?
    @IBOutlet weak var uiMessageComposer:UITextView?
    var bro:App.BroInfo?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = bro?.nick
        
        // Já entra com o campo de text em foco
        uiMessageComposer?.becomeFirstResponder()
        
        // Marca que a tabela tem cells de altura diferente
        // dependendo do texto
        uiList?.estimatedRowHeight = UITableViewAutomaticDimension
        uiList?.rowHeight = UITableViewAutomaticDimension
        
        // TODO-11
        // Escutar o aviso de que novas mensagens chegaram
        NotificationCenter.default.addObserver(forName: NSNotification.Name("chat-mudou"), object: nil, 
                                               queue: OperationQueue.main) { _ in
            self.uiList?.reloadData()
        }
    }
    
    @IBAction func send(){
        // TODO-12
        guard let texto = uiMessageComposer?.text,
              let bro  = bro else {
              return  
        }
        
        app.send(text: texto, toBro: bro)
        uiMessageComposer?.text = ""
    }
    
}

extension RoomViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Apenas uma sessão
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Quantidade de cells: número de mensagem vindas desse bro
        guard let bro = bro else { return 0 }
        return app.messages(from: bro).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // A celula tem a mesma classe, mas dois layout
        // Se for eu falando, usa 'meTalking', onde o balão
        // está a direita, do contrário usa 'broTalking'
        guard let bro   = bro else { fatalError() }
        let message     = app.messages(from:bro)[indexPath.row]
        let cellName    = message.isMe ? "meTalking" : "broTalking"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:cellName) as? ChatTableViewCell else{
                fatalError()
        }
        
        // Preenche o texto a informações de cor e emoji
        // na cell de chat
        if message.isMe {
            cell.uiBubble?.leftArrow = false
            cell.uiBubble?.color = UIColor(white: 0.9, alpha: 1.0)
        }else{
            cell.uiBubble?.leftArrow = true
            cell.uiEmoji?.text = bro.emoji
            cell.uiBubble?.changeColor(withSeed: bro.tag)
        }
        
        cell.uiText?.text = message.text
        return cell
    }
    
}


extension RoomViewController: UITextFieldDelegate {
    
    // O pula linha aqui pula linha mesmo!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let composer = self.uiMessageComposer {
            composer.text = (composer.text ?? "") + "\n"
        }
        return true
    }
    
}
