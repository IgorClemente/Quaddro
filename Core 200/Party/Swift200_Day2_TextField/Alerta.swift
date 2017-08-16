//
//  Alerta.swift
//  Swift200_Day2_TextField
//
//  Created by Igor Clemente on 12/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class Alerta : UIView {
    
  override init(frame: CGRect) {
    
    super.init(frame:frame)
    self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    self.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    
    let viewWhite =  UIView()
    viewWhite.frame = CGRect(x: 0,y: 0,width: 200,height: 140)
    viewWhite.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
    viewWhite.backgroundColor = UIColor.white
    self.addSubview(viewWhite)
  }

  //Nossa classe não é utilizada via interface builder
  required init?(coder aDecoder: NSCoder) {
    fatalError("Não é assim que usa!")
  }
}
