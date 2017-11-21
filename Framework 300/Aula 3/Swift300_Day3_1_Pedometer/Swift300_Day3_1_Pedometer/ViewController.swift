//
//  ViewController.swift
//  Swift300_Day3_1_Pedometer
//
//  Created by Nilo on 17/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var uiProgress:ProgressView?
    @IBOutlet weak var uiEgg:RemelexoView?
    @IBOutlet weak var uiEggIcon:UILabel?
    
    @IBOutlet weak var uiSteps: UILabel?
    
    private var numberOfSteps = 0
    private var distanciaMaxima:CGFloat     = 10.0
    private var distanciaPercorrida:CGFloat = 0.0 
    
    
    // Gestor
    let gestor = CMPedometer()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.uiProgress?.value = 0.0
        
        if CMPedometer.isStepCountingAvailable() {
            self.gestor.startUpdates(from: Date(), withHandler: receber(dado:error:))
        }
    }

    func receber(dado:CMPedometerData?,error:Error?) {
        
        DispatchQueue.main.async {
            if let d = dado,
               let s = self.uiSteps {
               self.numberOfSteps = Int(d.numberOfSteps.int64Value)
                
               if let distancia = d.distance as? CGFloat {
                  self.verificar(distancia)
               }    
            }else{
                print("Error")
            }
        }
    }

    func verificar(_ distancia:CGFloat) {
        
        distanciaPercorrida += distancia
        let valorProgresso = min(1.0,distanciaPercorrida*distanciaMaxima/100)
        self.uiProgress?.value = valorProgresso
        
        if valorProgresso == 1.0 {
            self.shakeIt()
            self.hatch()
            self.gestor.stopUpdates()
            self.uiSteps?.text = "\(distanciaPercorrida)"
            distanciaPercorrida = 0.0
        }
    }
    
    
    // Tap no ovo
    @IBAction func tapOnEgg(){
        self.uiEggIcon?.text = "🥚"
        self.uiProgress?.value = 0.0
        self.gestor.startUpdates(from: Date(), withHandler: receber(dado:error:))
        print("TAPE EGG")
    }
    
    // Chame essa função para chocar
    func hatch(){
        let animals = Array("🐣🐥🦉🦆🐢🐍🦎".characters)
        let choosen = animals[ Int(arc4random()+1) % animals.count]
        self.uiEggIcon?.text = "\(choosen)"
    }
    
    // Chame essa função para chacoalhar o ovo
    func shakeIt(){
        self.uiEgg?.animar()
    }
    
}

