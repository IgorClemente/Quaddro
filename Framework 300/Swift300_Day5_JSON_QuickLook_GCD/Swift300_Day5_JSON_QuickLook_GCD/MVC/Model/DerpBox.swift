//
//  DerpBox.swift
//  Swift300_Day5_JSON_QuickLook_GCD
//
//  Created by Swift on 02/12/2017.
//  Copyright © 2017 Nilo. All rights reserved.
//

import Foundation

// Esse arquivo conversa com o servidor

class Derpbox {
    
    static let compartilhado = Derpbox()
    private init(){}
    
    //  cpuB.async{
    //  ... codigo a ser executado na CPUB
    //  }
    var cpuB:DispatchQueue = DispatchQueue(label: "derpQueue")
    
    let enderecoBase:String = "https://api.dropboxapi.com/2"
    
    // Esse método vai trazer dados da internet dando suporte a outros métodos
    func dados(vindoDe endpoint:String, body:[String:String]? = nil, headers:[String:String]? = nil) -> Data? {
        
        // 1) Converter a string em URL
        guard let url = URL(string: endpoint) else {
            print("A URL está com o formato errado !")
            return nil
        }
        
        // 2) Converter a URL em Request 
        var request = URLRequest(url: url)
        request.setValue(freeToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        if let h = headers,
           let headerData = try? JSONSerialization.data(withJSONObject: h, 
                                                        options: JSONSerialization.WritingOptions()) {
           let jsonString = String(data: headerData, encoding: .utf8)
           request.addValue(jsonString ?? "", forHTTPHeaderField: "Dropbox-API-Arg")
        }
        
        if let b = body {
           request.setValue("application/json", forHTTPHeaderField: "Content-Type") 
            // Como transformar um [String:Any] numa String JSON 
           request.httpBody = try? JSONSerialization.data(withJSONObject: b, options: .prettyPrinted) 
        }
        
        // 3) Criar e despachar um Datatask
        let config = URLSessionConfiguration.default     // Config Default é a melhor na opnião do sistema
        let session = URLSession(configuration: config)  // Sessão é o controlador do Sistema para todas requisições 
        let semaforo = DispatchSemaphore(value: 0)       // Semáfoto é tipo isso mesmo, ele dá sinal vermelho, o código
        
        var dadosRecebidos:Data?
        
        session.dataTask(with: request) { (data, _, _) in
            dadosRecebidos = data
            // Sinal verde, pode continuar
            semaforo.signal()
                
        }.resume()
            
        // Sinal vermelho, vai parar aqui até terminar o Download
        let _ = semaforo.wait(timeout: .distantFuture) 
    
        return dadosRecebidos
    }
    
    func sobreEU(_ closure: @escaping (Usuario?) -> ()) {
        
        cpuB.async {
            // Essa é a localização na internet da informação
            // de quem sou eu, no DropBox
            let endpoint = "\(self.enderecoBase)/users/get_current_account"
            
            guard let data = self.dados(vindoDe: endpoint) else {
                fatalError("Endereco inválido para conta do usuário")
            }
            
            // Agora vamos converter de Bytes -> (JSON) -> [String:Any]
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()),
                let jsonObject = jsonData as? [String:Any] else {
                    fatalError("Formato inválido")
            }
            
            // Agora temos [String:Any]!!
            // é só passar para STRUCT USUÁRIO
            guard let usuario = Usuario(data: jsonObject) else {
                fatalError("SLC, quase deu certo! Faltou campo :(")
            }
            
            DispatchQueue.main.async {
                closure(usuario)
            }
        }
    }
    
    func listarPasta(comCaminho caminho:String = "", depois closure:@escaping ([Conteudo])->()) {
        
        cpuB.async {
            let endPoint = "\(self.enderecoBase)/files/list_folder"
            
            // Primeiro baixamos os bytes do endpoint
            guard let data = self.dados(vindoDe: endPoint,body: ["path":caminho]) else {
                fatalError("O download dos dados falhou!")
            }
            
            // Depois tranformar os bytes em [String:Any]
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()),
                let jsonObject = jsonData as? [String:Any] else {
                    fatalError("Formato inválido!")  
            }
            
            // Recuperar entries como uma lista
            guard let lista = jsonObject["entries"] as? [[String:Any]] else {
                fatalError("Cade a lista ?")
            }
            
            var conteudos:[Conteudo] = []
            for dados in lista {
                if let conteudo = Conteudo(data: dados) {
                    conteudos.append(conteudo)  
                }
            }
            
            DispatchQueue.main.async {
                closure(conteudos)
            }
        }
    }
}
