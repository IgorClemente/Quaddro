//
//  AlertaView.swift
//  Swift200_Day2_TextField
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class AlertaView : UIView {
    
    init(frame: CGRect, texto:String) {
        super.init(frame: frame)
        
        // fundo escuro
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // fundo
      
        let fundo = UIView()
            fundo.frame = CGRect(x:0,y:0,width:220,height:120)
            fundo.backgroundColor = UIColor.white
            fundo.autoresizingMask = [.flexibleTopMargin,
                                      .flexibleRightMargin,
                                      .flexibleBottomMargin,
                                      .flexibleLeftMargin]
            fundo.center = self.center
        self.addSubview(fundo)
      
        // texto
        let campoTexto = UILabel()
            campoTexto.frame = CGRect(x:10,y:10,width:200,height:80)
            campoTexto.font = UIFont.systemFont(ofSize: 12)
            campoTexto.text = texto
        // Por padrão o label mostra só uma linha
        // Trocamos para zer de modo que pule quantas
        // forem necessárias
      
        campoTexto.numberOfLines = 0
        fundo.addSubview(campoTexto)
      
        // botao
        
      let botão = UIButton(type: .system)
      botão.frame = CGRect(x:10,y:80,width:200,height:30)
      
      // white: 0.9 -> Cinza, 90% de branco
      botão.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
      botão.setTitle("Entendi", for: .normal)
      fundo.addSubview(botão)
      
      botão.addTarget(self, action: #selector(tapFechar), for: .touchUpInside)   // #selector - transforme em código objC
      
      //setup da animação
      
      self.alpha = 0.0
      let centroFinal = fundo.center
      let centroAntes = CGPoint(x: fundo.center.x,
                                y: fundo.center.y  - 50)
      
      fundo.alpha = 0.0
      fundo.center = centroAntes
      
      //declarar animação
      UIView.animate(withDuration: 0.2) { self.alpha = 1.0
                                          fundo.center = centroFinal
                                          fundo.alpha = 1.0
                                    }
      
    }
  
    func tapFechar() {
      // animação  
      // dentro do bloco de animação podemos passar options definindo qual o tipo de animação queremos usar
      UIView.animate(withDuration: 0.2, animations: { self.alpha = 0.0 }) { _ in 
                                                                            self.removeFromSuperview() }
    }
  
    // Evitando uso errado da classe
    required init?(coder aDecoder: NSCoder) {
        fatalError() // Aqui o compilador não prossegue e mostra o erro ocorrido
    }
    
}
