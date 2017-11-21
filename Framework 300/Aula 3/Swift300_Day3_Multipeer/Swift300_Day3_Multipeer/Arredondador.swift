//
//  Arredondador.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class Arredondador: NSObject {

    @IBInspectable var radii:CGFloat = 0
    
    @IBOutlet var uiAlvos:[UIView]? {
        didSet{
            for view in uiAlvos ?? [] {
                view.layer.cornerRadius = radii
                view.clipsToBounds = true
            }
        }
    }
    
}
