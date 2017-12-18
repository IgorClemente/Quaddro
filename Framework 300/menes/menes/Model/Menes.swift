//
//  Menes.swift
//  menes
//
//  Created by Swift on 16/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import Foundation

/*
"name": "Cacete de agulha, nossinhora.",
"thumb": "https://i.ytimg.com/vi/3PRIUNZzYfI/hqdefault.jpg?sqp=-oaymwEXCPYBEIoBSFryq4qpAwkIARUAAIZCGAE=&rs=AOn4CLAF05TpCx7lHbCmjutKMS_LOi7H7A",
"url": "https://www.youtube.com/watch?v=oMrwhW2Tr4k",
"html": true,
"length": 68
*/


// Decodable mode ON

struct Meme : Decodable {
    let name:String 
    let thumb:URL
    let url:URL
    let html:Bool
    let length:Int
}

struct MemeList : Decodable {
    let menes:[Meme]
}

func todosMenes() -> [Meme] {
    
    // Como faz para ler um arquivo json do disco
    // 1) Descobrir o endereco dele, pelo nome 
    // 2) Pelo endereco buscar os Bytes (Data)
    // 3) Fazer o Decode com o data, apontando a struct de referencia
    
    // 1) 
    guard let arquivo = Bundle.main.url(forResource: "menes", 
                                        withExtension: "json") else {
        fatalError()
    }
    
    // 2)
    guard let data = try? Data(contentsOf: arquivo) else {
        fatalError()
    }
    
    // 3)
    do{
        let todos = try JSONDecoder().decode(MemeList.self, from: data)
        return todos.menes
    }catch{
        print("Eita deu ruim")
        return []
    }
}
