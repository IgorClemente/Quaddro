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
    
    
    @IBAction func tapTocaRock() {
        stream.change(toStation: .rock)
    }
    
    @IBAction func tapTocaPop() {
        stream.change(toStation: .pop)
    }
    
    @IBAction func tapTocaEcletica() {
        stream.change(toStation: .ecletic)
    }
    
    @IBAction func tapTocaDance() {
        stream.change(toStation: .dance)
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
            case .remoteControlNextTrack
            // Implementar
            default:
                return
        }
    }    
}

