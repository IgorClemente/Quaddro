//
//  Conteudo.swift
//  Swift300_Day5_JSON_QuickLook_GCD
//
//  Created by Swift on 02/12/2017.
//  Copyright © 2017 Nilo. All rights reserved.
//

/*{
  "entries": [
    {
      ".tag": "folder",
      "name": "Memes",
      "path_lower": "/memes",
      "path_display": "/Memes",
      "id": "id:4tifb0XSkfAAAAAAAAAACA"
    },
    {
      ".tag": "folder",
      "name": "Times",
      "path_lower": "/times",
      "path_display": "/Times",
      "id": "id:4tifb0XSkfAAAAAAAAAADA"
    },
    {
      ".tag": "folder",
      "name": "Docs",
      "path_lower": "/docs",
      "path_display": "/Docs",
      "id": "id:4tifb0XSkfAAAAAAAAAAGg"
    },
    {
      ".tag": "folder",
      "name": "Quaddro",
      "path_lower": "/quaddro",
      "path_display": "/Quaddro",
      "id": "id:4tifb0XSkfAAAAAAAAAAHQ"
    },
    {
      ".tag": "file",
      "name": "Get Started with Dropbox.pdf",
      "path_lower": "/get started with dropbox.pdf",
      "path_display": "/Get Started with Dropbox.pdf",
      "id": "id:4tifb0XSkfAAAAAAAAAABQ",
      """: "2017-11-30T16:15:09Z",
      "server_modified": "2017-11-30T16:15:09Z",
      "rev": "16fd8d290",
      "size": 1102331,
      "content_hash": "f7ad488deb7d81790340ecd676fe6e47f0a6064fb99b982685b752d58611c1cb"
    },
    {
      ".tag": "file",
      "name": "Get Started with Dropbox Paper.url",
      "path_lower": "/get started with dropbox paper.url",
      "path_display": "/Get Started with Dropbox Paper.url",
      "id": "id:4tifb0XSkfAAAAAAAAAABg",
      "client_modified": "2017-11-30T16:15:09Z",
      "server_modified": "2017-11-30T16:15:09Z",
      "rev": "26fd8d290",
      "size": 81,
      "content_hash": "16f386add4634a2e6e5a7fc782c51131a5347b9aabcc3cade0bc6c8bf7e304d9"
    }
  ],
  "cursor": "AAHCbZmK3b0VPMpODhsDdarIsmvZH14ggDGIueDnouAtEmFkgUKzkkeJ-TBYE4rqdRa8ahlIfMVPOLQujJYcW28lRynpjosM7nGrkF1mkz-ane00wTfr5T_5kO4aueojwWSu2p1oeQcWttKelMcH2D7M",
  "has_more": false
}*/


import Foundation


struct Conteudo {
    
    enum Tag : String {
        // O nome bate com  o conteudo 
        case folder, file
    }
    
    let tag:Tag 
    let nome:String 
    let caminho:String 
    let modificadoEm:Date?

    init?(data:[String:Any]) {
        // recuperar o campo 'nome'
        guard let nome = data["name"] as? String else {
            return nil
        }  
        self.nome = nome
        
        // recuperar o campo 'caminho'
        guard let caminho = data["path_lower"] as? String else {
            return nil
        }
        self.caminho = caminho
        
        // recuperar o campo 'modificadoEm'
        let formatador = DateFormatter()
        formatador.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let dataModificacao = data["server_modified"] as? String,
           let modificadoEm = formatador.date(from: dataModificacao){
           self.modificadoEm = modificadoEm 
        }else{
            self.modificadoEm = nil
        }
        
        // recuperar o campo 'tag'
        guard let tagString = data[".tag"] as? String,
              let tag = Tag(rawValue: tagString) else {
              return nil
        }
        self.tag = tag
    }
    
    // funções auxiliares
    // retornar o tipo de arquivo, tipo a extensão
    var extensaoDoArquivo:String? {
        guard tag == .file else {
            return nil
        }
        return nome.components(separatedBy: ".").last ?? ""
    }
    
    // Mostra a data, no formato: segunda, 13 de setembro ..
    var dataBonitinha:String? {
        guard let d = self.modificadoEm else {
            return nil
        }
        
        let formatador = DateFormatter()
        formatador.dateStyle = .full
        return formatador.string(from: d)
    }
}
