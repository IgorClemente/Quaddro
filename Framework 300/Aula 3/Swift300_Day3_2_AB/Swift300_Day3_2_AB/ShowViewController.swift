//
//  ShowViewController.swift
//  Swift300_Day3_2_AB
//
//  Created by Nilo on 18/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

/*
 
 👩🏻‍🍳 Implementando o AB
 1) Adicione o gestor, função de update e normalize os dados
 2) O que acontece em cada eixo? O que acontece quando virado para baixo?
 3) Implemente a vibração quando virado para baixo
 4) O que acontece quando viro de um lado ou de outro?
 5) Implemente a troca de texto dependendo do movimento
 
 💪🏻 Força!
 
 */

class ShowViewController: UIViewController {

    enum ChosenOne : String {
        case A, B, secret
    }
    
    @IBOutlet weak var uiResponse:UILabel?
    var chosen:ChosenOne = .secret
    
    let gestor = CMMotionManager()
    
    // Dica:
    
    // indica se o device já está virado para baixo
    // se 'pronto' = true já podemos monitorar o lado que vira
    // ou colocar o texto, dependendo de 'chosen'
    var pronto = false
    
    let hx = ValueHistory()
    let hy = ValueHistory()
    let hz = ValueHistory()
    
    var eixoz:Bool = false
    
    func receber(dado:CMAccelerometerData?,erro:Error?) {
        guard let d = dado else {
            return
        }
        
        hx.append(newValue: d.acceleration.x)
        hy.append(newValue: d.acceleration.y)
        hz.append(newValue: d.acceleration.z)
        
        if !pronto {
            if hz.average >= 0.4 {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            pronto = true
        }else{
            switch chosen {
              case .A: self.uiResponse?.text = "A"
              case .B: self.uiResponse?.text = "B"
              case .secret:
                if hx.average <= -0.4 {
                    self.uiResponse?.text = "A"
                    self.gestor.stopAccelerometerUpdates()
                }    
                if hx.average >= 0.4 {
                    self.uiResponse?.text = "B"
                    self.gestor.stopAccelerometerUpdates()
                }
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Na tela anterior foi escolhido:\(chosen.rawValue)")
        
        if gestor.isAccelerometerAvailable {
            gestor.startAccelerometerUpdates(to: OperationQueue.main, withHandler: receber(dado:erro:))
        }
    }
    
    @IBAction func tapPlayAgain(){
        dismiss(animated: true, completion: nil)
        self.gestor.startAccelerometerUpdates()
    }

}
