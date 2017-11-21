//
//  HallViewController.swift
//  Swift300_Day3_Multipeer
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class HallViewController: UIViewController {

    // Me identifica na rede unicamente
    var minhaID:MCPeerID?
    // Porteiro: cuida de quem está conectado e faz a ponte
    var sessao:MCSession?
    
    // A) Posso estar criando uma sala para o povo entrar
    // B) Posso estar entrando numa sala criada
    var assistenteDeCriar:MCBrowserViewController?
    var assistenteDeEntrar:MCAdvertiserAssistant?
    
    // Método que ajuda na criação da sessão
    func criaSessao() {
        if sessao == nil {
            let peer = MCPeerID(displayName: uiName?.text ?? "anom")
            sessao   = MCSession(peer: peer, securityIdentity: nil, encryptionPreference: .required)
            minhaID = peer
        }
    }
    
    @IBOutlet weak var uiName: UITextField?
    @IBAction func tapCreate() {
        
        // Se não existe, criar uma sessão
        // que é minha credencial e porta de saida
        criaSessao()
        if let s = sessao {
            let controller = MCBrowserViewController(serviceType: "qdd", session: s)
            present(controller, animated: true, completion: nil)
            assistenteDeCriar = controller
        }
    }
    
    @IBAction func tapJoin() {
        criaSessao()
        
        if let s = sessao {
            assistenteDeEntrar = MCAdvertiserAssistant(serviceType: "qdd", 
                                                       discoveryInfo: nil, 
                                                       session: s)
            assistenteDeEntrar?.start()
        }
    }
}
