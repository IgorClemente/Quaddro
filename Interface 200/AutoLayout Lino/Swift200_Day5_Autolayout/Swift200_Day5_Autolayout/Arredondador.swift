//
//  Arredondador.swift
//  Swift200_Day5_Autolayout
//
//  Created by Swift on 16/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class Arredondador : NSObject /* para funcionar no IB */ {
    
    @IBInspectable var radii:CGFloat = 10
    
    @IBOutlet var uiAlvos:[UIView]? {
        didSet{
            guard let alvos = uiAlvos else{
                return
            }
            
            for alvo in alvos {
                alvo.layer.cornerRadius     = radii
                alvo.clipsToBounds          = true
            }
        }
    }
}
