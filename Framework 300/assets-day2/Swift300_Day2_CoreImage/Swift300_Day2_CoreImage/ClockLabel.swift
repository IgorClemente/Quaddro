//
//  ClockLabel.swift
//  Swift300_Day2_CoreImage
//
//  Created by Nilo on 09/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class ClockLabel: UILabel {

    static let formatterH  = DateFormatter()
    static let formatterSH = DateFormatter()
    var tick = 0
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        ClockLabel.formatterH.dateFormat = "HH:mm"
        ClockLabel.formatterSH.dateFormat = "HH mm"
        update() 
    }
    
    func update(){
        
        tick += 1
        
        if tick % 2 == 0 {
            self.text = ClockLabel.formatterSH.string(from: Date())
        } else {
            self.text = ClockLabel.formatterH.string(from: Date())
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            [weak self] in
            self?.update()
        }
    }

}
