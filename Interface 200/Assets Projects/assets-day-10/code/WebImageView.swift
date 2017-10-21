//
//  WebImageView.swift
//  Pessoas
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {

    static var ramCache:[URL:UIImage] = [:]
    
    @IBInspectable var rounded:Bool = false {
        didSet {
            if rounded {
                self.layer.cornerRadius =
                            min(self.frame.width, self.frame.height)/2.0
                self.clipsToBounds = true
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
    
    var url:URL? {
        didSet{
            
            self.image = nil
            
            guard let url = self.url else{
                return
            }
            
            if let cached = WebImageView.ramCache[url] {
                self.image = cached
            }else{
                DispatchQueue.global().async {
                    
                    guard let picData = try? Data(contentsOf: url) else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: picData)
                        WebImageView.ramCache[url]  = self.image
                    }
                }
            }
        }
    }

}
