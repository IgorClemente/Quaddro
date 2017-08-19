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
    
    let boxWhite =  UIView()
    boxWhite.frame = CGRect(x:0,y:0,width:230,height:140)
    boxWhite.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin]
    boxWhite.backgroundColor = UIColor.white
    boxWhite.center = self.center
    
    let messageError = UILabel()
    messageError.frame = CGRect(x:0,y:0,width:200,height:30)
    messageError.textAlignment = .justified
    messageError.numberOfLines = 1
    messageError.text = "Preencha todos os campos"
    
    boxWhite.addSubview(messageError)
    self.addSubview(boxWhite)
  }

  //Nossa classe não é utilizada via interface builder
  required init?(coder aDecoder: NSCoder) {
    fatalError("Não é assim que usa!")
  }
}
