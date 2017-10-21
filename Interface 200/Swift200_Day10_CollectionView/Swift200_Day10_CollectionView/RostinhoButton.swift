//
//  RostinhoButton.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class RostinhoButton: UIButton {

    
    // Tipo é equivalente ao is da person
    // happy, sad, etc
    @IBInspectable var tipo:String = "happy" {
        didSet {
            preparaInterface()
        }
    }
    
    // Arrumar a imagem do botão
    func preparaInterface(){
        
    }
}
