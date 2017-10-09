//
//  SubMenuArvores.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 08/10/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class SubMenuArvores : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let fundoSubArvores   = UIView()
        fundoSubArvores.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
        fundoSubArvores.backgroundColor = UIColor.gray
        
        let stack       = UIStackView()
        stack.axis      = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        fundoSubArvores.addSubview(stack)
        self.addSubview(fundoSubArvores)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
