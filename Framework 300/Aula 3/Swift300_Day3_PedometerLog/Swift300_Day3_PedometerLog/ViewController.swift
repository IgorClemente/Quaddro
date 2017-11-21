//
//  ViewController.swift
//  Swift300_Day3_PedometerLog
//
//  Created by Nilo on 18/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import CoreMotion


/*
 
 👨🏻‍🍳 Como obter dados do pedometer
 
    1) Adicionar texto de permissão no info.plist
    2) Incluir o CoreMotion
    3) Criar let do gestor
    4) Criar função que receberá os dados
    5) Pedir updates para o gestor
 
*/

class ViewController: UIViewController {

    @IBOutlet weak var uiLogView:UITextView?
    
    let gestor = CMPedometer()
    
    func receberDados(dado:CMPedometerData?, error:Error?) {
        // Exibir o log no campo de texto
        // O dado do acelerometro vem em uma thread diferente
        
        DispatchQueue.main.async {
            if let d = dado {
                self.uiLogView?.text = d.description
            }else{
                self.uiLogView?.text = "Erro"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CMPedometer.isStepCountingAvailable() {
            gestor.startUpdates(from: Date(), withHandler: receberDados(dado:error:))
        }
    }
    
    
    

}

