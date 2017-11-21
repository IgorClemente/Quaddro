//
//  ValueHistory.swift
//  Acell
//
//  Created by Nilo on 16/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class ValueHistory {

    let size = 10
    var rawData:[Double] = []
    
    var average:Double {
        let sum = rawData.reduce(0, +)
        return sum/Double(rawData.count)
    }
    
    func append(newValue:Double) {
        rawData.append(newValue)
        if rawData.count > self.size {
           rawData.remove(at: 0)
        }
    }
    
}
