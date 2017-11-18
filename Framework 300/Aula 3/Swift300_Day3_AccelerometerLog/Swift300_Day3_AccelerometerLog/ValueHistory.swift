//
//  ValueHistory.swift
//  Acell
//
//  Created by Nilo on 16/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class ValueHistory {

    var rawData:[Double] = []
    let size:Int
    
    init(size:Int = 10) {
        self.size = size
    }
    
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
