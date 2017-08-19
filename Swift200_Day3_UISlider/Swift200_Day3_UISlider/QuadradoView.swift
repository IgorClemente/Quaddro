//
//  QuadradoView.swift
//  Swift200_Day3_UISlider
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class QuadradoView : UIView, DaquelesQueMudamDeCor {

  func alteraCor(paraNovaCor cor:UIColor) {
    self.backgroundColor = cor
  }
   
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    let contaGotas = ContaGotasViewController(
      // nib name é o nome do arquivo xib
      nibName: "ContaGotasViewController",
      // nil em bundle significa nosso próprio pacote (app)
      bundle: nil )
    
    // Permite que a view que está atrás fique visivel
    contaGotas.modalPresentationStyle = .overCurrentContext 
    contaGotas.modalTransitionStyle = .crossDissolve
    
    let tela = UIApplication.shared.keyWindow?.rootViewController
    tela?.present(contaGotas,animated: true, completion: nil)
    
    contaGotas.quemMeuChamou = self
    contaGotas.definirCor(self.backgroundColor ?? UIColor.white)
  }

}
