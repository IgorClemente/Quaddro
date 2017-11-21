//
//  ViewController.swift
//  Swift300_Day3_AccelerometerLog
//
//  Created by Nilo on 18/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import CoreMotion

/*
 
 👨🏻‍🍳 Como obter dados do accelerometer
 
 1) Incluir o CoreMotion
 2) Criar let do gestor
 3) Criar função que receberá os dados
 4) Pedir updates para o gestor
 5) Opcional: normalizar os dados
 
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var uiLog:UITextView?
    
    let gestor = CMMotionManager()
    
    let hx = ValueHistory(size: 30)
    let hy = ValueHistory(size: 30)
    let hz = ValueHistory(size: 30)
    
    func receber(dado:CMAccelerometerData?,erro:Error?) {
        guard let d = dado else {
            return
        }
        
        hx.append(newValue: d.acceleration.x)
        hy.append(newValue: d.acceleration.y)
        hz.append(newValue: d.acceleration.z)
        
        var info = String(format:"%.1f\n",hx.average)
        info += String(format: "%.1f\n",hy.average)
        info += String(format: "%.1f\n",hz.average)
        self.uiLog?.text = info
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gestor.isAccelerometerAvailable {
            gestor.startAccelerometerUpdates(to: OperationQueue.main, withHandler: receber(dado:erro:))
        }
    }
}

