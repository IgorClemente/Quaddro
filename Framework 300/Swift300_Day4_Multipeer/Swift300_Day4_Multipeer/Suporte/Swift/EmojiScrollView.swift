//
//  EmojiScrollView.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class EmojiScrollView: UIView {

    var uiLabelA = UILabel()
    var uiLabelB = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        let height = self.frame.height * 0.5
        let text = "😻 🤙🏻 👽 😴 🤷🏻‍♂️ 🐸 🌚 😘 🍕 🐶 🤦🏻‍♀️ 🙄 "
        
        for label in [uiLabelA, uiLabelB] {

            label.font = UIFont.systemFont(ofSize: height)
            label.text = "\(text)"
            label.frame = CGRect(x: 0, y: 0,
                        width: label.intrinsicContentSize.width,
                        height: self.frame.height)
            
            self.addSubview(label)
        }
        
        step()
    }
    
    func step(){
        
        let textSize = uiLabelA.intrinsicContentSize.width
        
        uiLabelA.frame.origin.x = 0
        uiLabelB.frame.origin.x = textSize
        
        UIView.animate(withDuration: 32.0, delay: 0.0,
                       options: .curveLinear, animations: {
                        
            self.uiLabelA.frame.origin.x -= textSize
            self.uiLabelB.frame.origin.x -= textSize
                        
        }) { [weak self] _ in
            self?.step()
        }
    }

}
