//
//  App.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import UserNotifications

var app = App.shared

class App: NSObject {

    fileprivate static let shared = App()
    private override init() { super.init() }
    
    // Informações sobre mim
    // Nick, tag e emoji
    var meuNick:String = "anom"
    var meuTag:Int {
        return meuNick.unicodeScalars
            .flatMap{ Int($0.value) }
            .reduce(0, +)
    }
    var meuEmoji:String {
        let scalar = UnicodeScalar(128012 + (meuTag%48))
            ?? UnicodeScalar(UInt8(0x65))
        return "\(scalar)"
    }
    
    // Tupla de informações de alguém por perto
    // Tupla de uma mensagem
    typealias BroInfo = (nick:String, emoji:String, tag:Int)
    typealias Message = (from:String, isMe:Bool, text:String, date:Date)
    
    // TODO-1
    private var _meuPeer:MCPeerID? = nil
    var meuPeerId:MCPeerID {
        // Já existe
        if let p = _meuPeer {
            return p
        }else{
            let peer = MCPeerID(displayName: UIDevice.current.name)
            _meuPeer = peer
            return peer
        }
    }
    
    var brothers:[MCPeerID:BroInfo] = [:]
    
    
    // TODO-2
    private var _sessao:MCSession? = nil
    var sessao:MCSession {
        if let s = _sessao {
            return s
        }else{
            let s = MCSession(peer: meuPeerId, 
                              securityIdentity: nil, 
                              encryptionPreference: .none)
            _sessao = s
            _sessao?.delegate = self as? MCSessionDelegate
            return s
        }
    }
    
    // TODO-3
    var busca:MCNearbyServiceBrowser?
    var ade:MCNearbyServiceAdvertiser?
    
    func conectarTudo() {
        // Isso é tipo meu cartão de visitas 
        // Na rede
        let sobreMim = [
            "nome": meuNick,
            "emoji": meuEmoji,
            "tag": "\(meuTag)"
        ]
        
        print("sessao \(sessao)")
        
        // Aceitando conexões
        ade = MCNearbyServiceAdvertiser(peer: meuPeerId, 
                                        discoveryInfo: sobreMim,
                                        serviceType: "qchat2")
        ade?.delegate = self as? MCNearbyServiceAdvertiserDelegate
        ade?.startAdvertisingPeer()
        
        // Procurando por outros Peers
        busca = MCNearbyServiceBrowser(peer: meuPeerId, serviceType: "qchat2")
        busca?.delegate = self as? MCNearbyServiceBrowserDelegate
        busca?.startBrowsingForPeers()
        
        print("Oi, eu sou o goku, \(sobreMim)")
        print("Procurando ...")
    }
    
    
    // TODO-13
    // Vamos garantir que quando eu voltar para a home, o app desfaz a sessão anterior
    func desconectarTudo(){
        ade?.stopAdvertisingPeer()
        busca?.stopBrowsingForPeers()
        sessao.disconnect()
        sessao.delegate = nil
        
        ade   = nil
        busca = nil
        _meuPeer = nil
        _sessao  = nil
        brothers = [:]
        _messagens = [:]
    }
    
    // Metodos que as classes usam
    // send -> envia uma mensagem para alguém
    // messages(from:) -> histórico de mensagem
    // connectedBros -> lista de bros conectados
    func send(text:String, toBro bro:BroInfo) {
        
        // TODO-10
        guard let peer = broToPeer(bro),
              let data = text.data(using: .utf8) else {
              return
        }
        try? sessao.send(data, toPeers: [peer], with: .reliable)
        
        let novaMensagem:Message = (meuNick, true, text, Date())
        var todasMensagens = _messagens[peer] ?? []
        todasMensagens.append(novaMensagem)
        _messagens[peer] = todasMensagens
        
        // Isso avisa as telas que há novas mensagens
        NotificationCenter.default.post(name: NSNotification.Name("chat-mudou"), object: nil)
    }
    
    // Vamos preparar o vetor que guarda o texto recebido, vindo de um Peer
    // -> Como chega no delegate o peer, é mais fácil guard
    // pelo peerID
    
    var _messagens:[MCPeerID:[Message]] = [:]
    func messages(from bro:BroInfo) -> [Message] {
        // TODO-9
        guard let peer = broToPeer(bro) else {
            return []
        }
        return _messagens[peer] ?? []
    }
    
    var connectedBros:[BroInfo] {
        // TODO-7
        var todosAgora:[BroInfo] = []
        for peer in sessao.connectedPeers {
            if let info = brothers[peer] {
               todosAgora.append(info)
            }
        }
        return todosAgora
    }
    
    
    // TODO-8
    // Como vamos mandar mensagem??
    // Nesse caso preciso do contrário
    // Esse faz o contrário, de info para MCPeerID
    func broToPeer(_ bro:BroInfo) -> MCPeerID? {
        for brother in brothers {
            if brother.value.tag == bro.tag &&
               brother.value.nick == bro.nick {
               return brother.key 
            }
        }
        return nil
    }
}


// TODO-4
// Delegate do neaby service
extension App : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // Tamo Junto ;)
        invitationHandler(true,self.sessao)
    }
}

// TODO-5
// Recebemos um cartão de visitas
extension App : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // Não precisamos fazer nada nesse
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        // Aee, achou alguém!
        guard let i    = info,
              let nome = i["nome"],
              let emoji  = i["emoji"],
              let tagStr = i["tag"],
              let tag    = Int(tagStr) else {
            return
        }
        print("Ah lá, quem apareceu, \(emoji) \(nome)")
        
        // Achei alguém, coloco na lista de conhecidos
        // E mando um convite.
        brothers[peerID] = (nome, emoji, tag)
        
        
        browser.invitePeer(peerID, to: sessao, withContext: nil, timeout: 8.0)
        
        
        NotificationCenter.default.post(name: 
                                        NSNotification.Name("lista-mudou"), 
                                        object: nil)
    }
}

// TODO-15

extension App : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        // Quando eu receber um aviso que alguém saiu ou entrou,
        // Aproveito e peço update da lista
        NotificationCenter.default.post(name:
                                        NSNotification.Name("lista-mudou"),
                                        object: nil)
    }
    
    // sessionstream <enter>
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // NOPE
    }
    
    // sessionresource <enter>
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // NOPE
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // NOPE
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        guard let texto = String(data: data,encoding: .utf8),
              let bro   = brothers[peerID] else {
              return  
        }
        
        let novaMensagem:Message = (from: bro.nick, isMe: false, text: texto, date: Date()) 
        app._messagens[peerID] = [novaMensagem]
        NotificationCenter.default.post(name: NSNotification.Name("chat-mudou"), object: nil)
        print("Chegou! \(texto) enviado por \(bro.nick)")
        
        DispatchQueue.main.async {
            // Quando chegar uma msg, vejo se estou em Background
            // Se estiver, mostro uma UserNotification
            
            // Mas, mano, como é que eu sei disso ?
            if UIApplication.shared.applicationState == .background {
               let conteudo   = UNMutableNotificationContent()
                conteudo.body  = novaMensagem.text
                conteudo.title = "\(bro.emoji) \(bro.nick) diz:"
                
                let notificacao = UNNotificationRequest(identifier: "chat", content: conteudo, trigger: nil)
                UNUserNotificationCenter.current().add(notificacao, withCompletionHandler: nil)
            }
        }
    }
}

