//
//  ViewController.swift
//  Swift200_Day5_Autolayout
//
//  Created by Swift on 16/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var uiTodosFundos:[UIView]?
    var radioDisparadores:[String:UIButton] = [:]
    let stream = RadioStream()

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    @IBAction func tapAtualizaSeleção(_ sender: UIButton) {
        
        guard let fundos = uiTodosFundos else{
            return
        }
        
        for fundo in fundos {
            fundo.layer.borderColor  = UIColor.clear.cgColor
        }
        
        sender.superview?.layer.borderColor = UIColor.red.cgColor
        sender.superview?.layer.borderWidth = 2
        
    }
    
    
    @IBAction func tapTocaRock(_ sender:UIButton) {
        stream.change(toStation: .rock)
        radioDisparadores["rock"] = sender
    }
    
    @IBAction func tapTocaPop(_ sender:UIButton) {
        stream.change(toStation: .pop)
        radioDisparadores["pop"] = sender
    }
    
    @IBAction func tapTocaEcletica(_ sender:UIButton) {
        stream.change(toStation: .ecletic)
        radioDisparadores["ecletic"] = sender
    }
    
    @IBAction func tapTocaDance(_ sender:UIButton) {
        stream.change(toStation: .dance)
        radioDisparadores["dance"] = sender
    }
    
    
    //Control Events
    
    // Avisa o Sistema que pode ser o primeiro
    // Na fila de eventos
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // Pedimos para receber eventos na entrada da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    // Opa! recebemos eventos 
    override func remoteControlReceived(with event: UIEvent?) {
        
        guard let tipo = event?.subtype else {
            return
        }
        
        switch tipo {
            case .remoteControlPause, .remoteControlStop:
                stream.isPlaying = false
            case .remoteControlPlay:
                stream.isPlaying = true
            case .remoteControlNextTrack:
                var proxima:[String:Station] = [
                    "rock": .pop,
                    "pop": .ecletic,
                    "ecletic": .dance,
                    "dance": .rock
                ]
                
                guard let fundos = uiTodosFundos else{
                    return
                }
                
                for fundo in fundos {
                    fundo.layer.borderColor  = UIColor.clear.cgColor
                }
                
                if let atual = stream.currentStation {
                  
                  let viewSelecionada = self.radioDisparadores[atual.rawValue] ?? UIButton()
                  viewSelecionada.superview?.layer.borderColor = UIColor.red.cgColor
                  viewSelecionada.superview?.layer.borderWidth = 2
                  stream.change(toStation: proxima[atual.rawValue] ?? .rock)
                }
                
            default:
                return
        }
    }    
}

