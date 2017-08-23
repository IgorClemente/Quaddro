//
//  TerceiroViewController.swift
//  MeuApp
//
//  Created by Swift on 05/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class TerceiroViewController: UIViewController {
  
  @IBOutlet weak var uiMeuTexto: UILabel?
  @IBAction func tapPick(_ sender: UIButton) {
    
    //Quando dou tap, mostra e incrementa o contador
    self.view.viewWithTag(1)?.isHidden = false
    
    //aumenta o contador
    let atual = Int(uiMeuTexto?.text ?? "") ?? 0
    uiMeuTexto?.text = "\(atual+1)"
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World")
      
        //Capturando uma view pela sua TAG
        let umaView = self.view.viewWithTag(1)
        umaView?.isHidden = true
        
        //Alterando sua opacidade 
        self.view.viewWithTag(2)?.alpha = 0.2
        self.view.viewWithTag(3)?.alpha = 0.5
        
        //Alterando sua cor 
        self.view.viewWithTag(4)?.backgroundColor = UIColor.blue
      
        //Curiosidade sobre sub e super view
        print("Terceira tela tem: ", self.view.subviews.count,"subs")
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let view = touches.first?.view else {
          return
        }

        if view.tag == 4 {
          dismiss(animated: true, completion: nil)
        }
    }
}
