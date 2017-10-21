//
//  RostinhoButton.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

 @IBDesignable class RostinhoButton: UIButton {

    
    // Todo mundo que tá do meu lado
    @IBOutlet var dosLados:[RostinhoButton]?
    
    // Tamanho natural do conteudo
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: 30)
    }

    // Toda vez que configurar a pessoa
    // já vejo se o is dela bate com meu tipo
    // se sim, acende o ícone (=enabled false)
    var pessoa:Person? {
        didSet {
            if pessoa?.is.rawValue == self.tipo {
                self.isEnabled = false
            } else {
                self.isEnabled = true
            }
        }
    }
    
    // Tipo é equivalente ao is da person
    // happy, sad, etc
    @IBInspectable var tipo:String = "happy" {
        didSet {
            preparaInterface()
        }
    }
    
    // Arrumar a imagem do botão
    func preparaInterface(){
        // Quero as duas imagens - aceso e apagado
        let pacote = Bundle(for: type(of: self))
        
        guard let imagemNormal = UIImage(named: tipo, in: pacote, compatibleWith: nil),
              let imagemOff    = UIImage(named: "\(tipo)-off", in: pacote, compatibleWith: nil) else {
            return
        }
        
        self.setBackgroundImage(imagemNormal, for: .disabled)
        self.setBackgroundImage(imagemOff, for: .normal)
        
        self.addTarget(self, action: #selector(troca), for: .touchUpInside)
    }
    
    func troca() {
        for doLado in dosLados ?? [] {
            doLado.isEnabled = true
        }
        
        self.isEnabled = false
        
        // Já que estamos aqui
        // Atualizamos o is da pessoa
        if let novoTipo = Is(rawValue: self.tipo) {
            self.pessoa?.is = novoTipo
        }
    }
}
