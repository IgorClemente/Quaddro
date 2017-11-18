//
//  RemelexoView.swift
//  Ovoji
//
//  Created by Nilo on 17/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class RemelexoView: UIView {

    func animar(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration      = 0.04
        animation.repeatCount   = 3
        animation.autoreverses  = true
        animation.byValue       = CGPoint(x: 0, y: -10)
        layer.add(animation, forKey: "position")
    }

}
