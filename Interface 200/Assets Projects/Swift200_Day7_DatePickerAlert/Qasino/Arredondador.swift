//
//  Arredondador.swift
//  LePizza
//
//  Created by Luiz Gustavo Lino on 10/1/16.
//  Copyright © 2016 Luiz Gustavo Lino. All rights reserved.
//

import Foundation
import UIKit

class Arredondador : NSObject {
    
    @IBInspectable var raio:CGFloat = 10
    
    @IBOutlet var alvos:[UIView]? {
        didSet{
            guard let alvos = self.alvos else{
                return
            }
            
            for alvo in alvos{
                alvo.layer.cornerRadius = raio
            }
        }
    }
    
}