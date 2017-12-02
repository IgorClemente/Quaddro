//
//  Arredondador.swift
//  Swift200_Day5_Autolayout
//
//  Created by Nilo on 02/09/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class Arredondador: NSObject {

    @IBInspectable var radii:CGFloat = 5
    
    @IBOutlet var uiAlvos:[UIView]? {
        didSet{
            for view in uiAlvos ?? [] {
                view.layer.cornerRadius = radii
                view.clipsToBounds = true
            }
        }
    }
    
}
