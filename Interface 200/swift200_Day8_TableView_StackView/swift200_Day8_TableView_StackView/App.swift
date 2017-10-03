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
        ("Londrina","ln","by Wilson Vieira","Londrina,br")
    ]
    
    var usarCelsius = true
    
    // Controler de cidade favorita
    var favorita = "Rio de Janeiro"
    
    func salvarFavorita(comNome nome:String) {
        // Antes de salvar a nova favorita, vamos confirmar que sabemos de quem se trata
        for cidade in cidades {
            if cidade.nome == nome {
                favorita = nome
                return 
            }
        }
    }
    
    func dadosDaFavorita() -> Cidade {
        // Quando preciso das informações
        // Busco a favorita na lista de cidade
        for cidade in cidades {
            if cidade.nome == favorita {
                return cidade 
            }
        }
        fatalError("Cidade não encontrada")
    }
}

