//
//  RedondoView.swift
//  Swift200_Day3_UISlider
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit



class RedondoView: QuadradoView {

  override func awakeFromNib() {
    self.layer.cornerRadius = frame.size.width/2
  }
}
