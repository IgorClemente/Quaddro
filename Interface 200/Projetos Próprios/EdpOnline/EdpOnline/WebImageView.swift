//
//  WebImageView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 20/11/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

@IBDesignable
class WebImageView : UIImageView {
    
    static var imagesCached:[URL:UIImage] = [:]
    
    var url:URL? {
       didSet{
         guard let url = self.url else {
           return
         }
         if let image = WebImageView.imagesCached[url] {
            self.image = image
         }else{
            DispatchQueue.global().async {
              guard let pictureData = try? Data(contentsOf: url) else{
                return
              }
              DispatchQueue.main.async {
                self.image = UIImage(data: pictureData)
                WebImageView.imagesCached[url] = self.image
              }
            }
         }
       }
    }
    
    @IBInspectable var rounded:Bool = true {
        didSet{
          if rounded {
             self.layer.cornerRadius = min(self.frame.width,self.frame.height)/2.0
             self.clipsToBounds = true
          }else{
             self.layer.cornerRadius = 0
          }
        }
    }
}
