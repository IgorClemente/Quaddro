//
//  DetalhesViewController.swift
//  Swift200_Day3_ImageView
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var uiNome: UILabel?
    @IBOutlet weak var uiTexto: UITextView?
    @IBOutlet weak var uiFoto: UIImageView?
  
    var opcaoEscolhida:String?
  
    // Para esconder a status bar, utilizamos
  
    override var prefersStatusBarHidden: Bool{
      return true
    }
     
    // mesmo que a tela prefira a barra escondida
    // para efeito de animações de entrada e sai, utilize branco
    override var preferredStatusBarStyle: UIStatusBarStyle{
      return .lightContent
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //arrendando a foto
      if let foto = uiFoto {
        let radius = foto.frame.size.width
        foto.layer.cornerRadius = radius/2
        print("Redondo")
      }
      
      if let opcao = opcaoEscolhida {
        switch opcao {
          case "cavalos":
            uiNome?.text = "Monumento\nàs Bandeiras"
            uiFoto?.image = UIImage(named:"ibira-2")
            uiTexto?.text = "Monumento às Bandeiras é uma obra de arte executada pelo escultor ítalo-brasileiro Victor Brecheret. A obra representa os bandeirantes, expondo suas diversas etnias e o esforço para desbravar o país. Além de portugueses, vemos na obra negros, mamelucos e índios, puxando uma canoa de monções, utilizadas nas expedições fluvias."
          case "pessoas":
            uiNome?.text = "Auditório"
            uiFoto?.image = UIImage(named:"ibira-4")
            uiTexto?.text = "Monumento às Bandeiras é uma obra de arte executada pelo escultor ítalo-brasileiro Victor Brecheret. A obra representa os bandeirantes, expondo suas diversas etnias e o esforço para desbravar o país. Além de portugueses, vemos na obra negros, mamelucos e índios, puxando uma canoa de monções, utilizadas nas expedições fluvias."        
          case "arvore":
            uiNome?.text = "Ponte sobre o Rio"
            uiFoto?.image = UIImage(named:"ibira-3")
            uiTexto?.text = "Monumento às Bandeiras é uma obra de arte executada pelo escultor ítalo-brasileiro Victor Brecheret. A obra representa os bandeirantes, expondo suas diversas etnias e o esforço para desbravar o país. Além de portugueses, vemos na obra negros, mamelucos e índios, puxando uma canoa de monções, utilizadas nas expedições fluvias."          
          case "obelisco":
            uiNome?.text = "Obelisco"
            uiFoto?.image = UIImage(named:"ibira-1")
            uiTexto?.text = "Monumento às Bandeiras é uma obra de arte executada pelo escultor ítalo-brasileiro Victor Brecheret. A obra representa os bandeirantes, expondo suas diversas etnias e o esforço para desbravar o país. Além de portugueses, vemos na obra negros, mamelucos e índios, puxando uma canoa de monções, utilizadas nas expedições fluvias."
          
          default: break
        }
      }
    }
    
    @IBAction func tapFechar() {
        dismiss(animated: true, completion: nil)
    }
}
