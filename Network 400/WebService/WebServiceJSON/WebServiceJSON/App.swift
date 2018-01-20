//
//  App.swift
//  WebServiceJSON
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class App: NSObject {

    var nome:String?
    var preco:String?
    var imagemURL:URL?
    
    /*
     Nome: im:name    > label
     Preço: im:price  > label
     Imagem: im:price > resgatar terceira posicao > label
     */
    
    // Criar uma método de inicialização customizado
    convenience init(dadosJSON: [String: Any]) {
        // Iniciar o objeto
        self.init()
        
        // Regastar os dados do JSON
        if let name = dadosJSON["im:name"] as? [String: String] {
            self.nome = name["label"]
        }
        
        if let price = dadosJSON["im:price"] as? [String: Any] {
            self.preco = price["label"] as? String
        }
        
        if let images = dadosJSON["im:image"] as? [[String: Any]] {
            guard let imageURLString = images[2]["label"] as? String else {
                return
            }
            self.imagemURL = URL(string: imageURLString)
        }
    }
}
