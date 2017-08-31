//
//  ControllerAux.swift
//  ColorPassword
//
//  Created by Igor Clemente on 09/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ControllerAux {

    private var tentativas:Int = 0
    
    func setAttemp() -> Void {
        self.tentativas += 1
        print("Mais um")
    }
    
    func getAttemp() -> Int {
        return tentativas
    }
}
