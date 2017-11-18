//
//  ProgressView.swift
//  Ovoji
//
//  Created by Nilo on 17/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class ProgressView : UIView {
    
    private var originalWidth:CGFloat = 0
    private weak var innerView:UIView?
    
    var value:CGFloat = 1.0 {
        didSet{
            guard let innerView = self.innerView else{
                return
            }
            var newSize = innerView.frame.size
            newSize.width = originalWidth * value
            innerView.frame.size = newSize
            innerView.layer.cornerRadius = self.layer.cornerRadius
        }
    }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        originalWidth = self.frame.size.width
        
        let innerView = UIView(frame: self.bounds)
        self.innerView = innerView
        self.innerView?.backgroundColor = self.backgroundColor
        self.backgroundColor = UIColor.clear
        self.addSubview(innerView)
        
    }

}
