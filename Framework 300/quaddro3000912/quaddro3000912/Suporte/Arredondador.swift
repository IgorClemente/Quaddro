//
//  Arredondador.swift
//  quaddro3000912
//
//  Created by Swift on 09/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class Arredondador : NSObject {
    
    @IBInspectable var radii:CGFloat = 10
    
    @IBOutlet var viewsParaArredondar:[UIView]? {
       didSet{
          guard let views = viewsParaArredondar else {
            return
          }
          for view in views {
              view.layer.cornerRadius = radii 
              view.clipsToBounds      = true 
          }
      }
   }
}
