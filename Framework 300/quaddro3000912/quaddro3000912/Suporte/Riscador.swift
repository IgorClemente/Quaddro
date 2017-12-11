//
//  Riscador.swift
//  quaddro3000912
//
//  Created by Swift on 09/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//


import UIKit

class Riscador: NSObject {
    @IBInspectable var width:CGFloat = 0
    @IBInspectable var color:UIColor = UIColor.black
    
    @IBOutlet var uiTargets:[UIView]? {
        didSet{
            for view in uiTargets ?? [] {
                view.layer.borderWidth = width
                view.layer.borderColor = color.cgColor
            }
        }
    }
}
