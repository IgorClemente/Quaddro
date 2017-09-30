//
//  App.swift
//  swift200_Day8_TableView_StackView
//
//  Created by Swift on 30/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import Foundation


class App {
    
    // Criando um singleton
    static let compartilhado = App()
    private init() {}
    
    typealias Cidade = (nome:String,       // Ex: São Paulo
                        bg:String,         // SP (Nome Imagem)
                        credito:String,    // Autor da Foto
                        code:String)       // para acessar a API
    
    var cidades:[Cidade] = [
        ("São Paulo","sp","by The Photographer","Saopaulo,br"),
        ("Rio de Janeiro","rj","by Rosino","Rio,br"),
        ("Brasilia","br","by Fabio Luiz","Brasilia,br"),
        ("Guarulhos","gr","by WWF","Guarulhos,br"),
        ("Londrina","ln","by Wilson Vieira","Londrina,pr")
    ]

}

