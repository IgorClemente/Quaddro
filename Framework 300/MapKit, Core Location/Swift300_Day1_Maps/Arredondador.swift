//
//  Arredondador.swift
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
                alvo.clipsToBounds = true
            }
        }
    }
    
}
