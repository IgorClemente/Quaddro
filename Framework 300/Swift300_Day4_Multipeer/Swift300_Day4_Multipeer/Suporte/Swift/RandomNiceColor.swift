//
//  RandomNiceColor.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class RandomNiceColor: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        changeColor(withSeed: Int(arc4random()))
    }
    
    func changeColor(withSeed seed:Int){
        
        self.layer.cornerRadius = min(
            self.frame.width/2, self.frame.height/2)
        
        let random = CGFloat(seed%10)/10.0
        
        self.backgroundColor = UIColor.init(hue: random,
                                            saturation: 0.8,
                                            brightness: 1.0,
                                            alpha: 1.0);
        
        
    }

}
