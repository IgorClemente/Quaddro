//
//  Arredondador.swift
//  Swift200_Day5_AutoLayout
//
//  Created by Swift on 02/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class Arredondador: NSObject {
  
  @IBInspectable var radii:CGFloat = 10
  
  @IBOutlet var uiAlvos:[UIView]? {
    didSet{
      for alvo in uiAlvos ?? [] {
        alvo.layer.cornerRadius = radii
        alvo.clipsToBounds = true      //Ativar ClipToBounds para que o campo de texto fique arredondado
      }
    }
  }
  
  
}
