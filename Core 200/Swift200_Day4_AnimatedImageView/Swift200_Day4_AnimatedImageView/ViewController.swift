//
//  ViewController.swift
//  Swift200_Day4_AnimatedImageView
//
//  Created by Swift on 26/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func adicionarPingo(naPosicao p:CGPoint) {
    
    // 1) Criar um vetor com todas UIImage dentro
    
    var imagens:[UIImage] = []
    
    for i in 1...32 {
      if let framePingo = UIImage(named:"drop\(i)"){
        imagens.append(framePingo)
      }
    }
    
    // 2) Fazer uma UIImageView, configurar tamanho e a posição dela
    
    let umPingo = UIImageView()
    umPingo.frame.size = imagens[0].size
    umPingo.center = p 
    self.view.addSubview(umPingo)
    
    // 3) Configurar a animação
    
    umPingo.animationRepeatCount = 1
    umPingo.animationDuration    = 0.6 + TimeInterval(arc4random()%6)/10.0
    umPingo.animationImages      = imagens
    umPingo.startAnimating()
    
    perform(#selector(remover(pingo:)),with: umPingo,afterDelay: umPingo.animationDuration)
  }
  
  func remover(pingo:UIImageView) {
    pingo.removeFromSuperview()
  }
  
  // touches.first? -> Optional
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let p = t.location(in: self.view) 
      adicionarPingo(naPosicao: p)
    }  
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let p = t.location(in: self.view) 
      adicionarPingo(naPosicao: p)
    }
  }
}

