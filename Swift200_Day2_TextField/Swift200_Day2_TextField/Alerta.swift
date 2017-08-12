//
//  Alerta.swift
//  Swift200_Day2_TextField
//
//  Created by Swift on 12/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class Alerta : UIView {
  
  override init(frame: CGRect) {
    
    super.init(frame:frame)
    // Fundo escuro
    self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    self.autoresizingMask = [.flexibleWidth,.flexibleHeight]
  }

  //Nossa classe não é utilizada via interface builder
  required init?(coder aDecoder: NSCoder) {
    fatalError("Não é assim que usa!")
  }
}
