//
//  Alerta.swift
//  Swift200_Day2_TextField
//
//  Created by Igor Clemente on 12/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class Alerta : UIView {
    
  private var optionalOvBtn = Dictionary<String,String>()
    
    
  
  override init(frame: CGRect) {
    
    super.init(frame:frame)
    // Fundo escuro 
    self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    self.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    
    // Botão - Caixa Confirm
    let botaoConfirmError = UIButton()
    botaoConfirmError.frame = CGRect(x:10,y:20,width: 100, height:100)
    botaoConfirmError.backgroundColor = UIColor.brown
    
    // Fundo Branco - Caixa
    let view =  UIView()
    view.addSubview(botaoConfirmError)
    view.backgroundColor = UIColor.white
    view.frame = CGRect(x:self.frame.size.width/5,y:self.frame.size.height/2.5,width:200,height:100)
    self.addSubview(view)
  }

  //Nossa classe não é utilizada via interface builder
  required init?(coder aDecoder: NSCoder) {
    fatalError("Não é assim que usa!")
  }
}
