//
//  ViewController.swift
//  EnglishLearn
//
//  Created by Igor Clemente on 17/08/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet var uiTodosCampos: [UILabel]?
    @IBOutlet weak var uiMessageLanguage: UILabel?
    @IBOutlet weak var uiTextField: UITextField?

    var messagesField:[String:String] = [
        "Olá do Igor":"Hello from Igor",
        "Esse é um cachorro":"It's a Dog"
    ]
    var messages:[String] = ["Olá do Igor","Esse é um cachorro"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.prepareMessages()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Perdeu foco")
    }
    
    
    func hiddenFields(_ textTcl:String) -> Void {
        
        guard let t = self.uiMessageLanguage.text else {
            return
        }
        
        let textCompare = messagesField[t]
    }
    
    
    func generatorBoxesMessage(_ worlds:[String]) -> Void {
        guard let campos = uiTodosCampos else {
            return
        }
        
        var gerados:[String] = worlds
        for (_,campo) in campos.enumerated() {
            let idxShuffle = arc4random_uniform(UInt32(gerados.count))
            campo.text = gerados[Int(idxShuffle)]
            gerados.remove(at:Int(idxShuffle))
        }
    }
    
    func prepareMessages() -> Void {
        guard let fieldText = uiMessageLanguage else {
            return
        }
        
        let idxShuffle = arc4random_uniform(UInt32(messages.count))
        let text = messages[Int(idxShuffle)]
        fieldText.text = text
        
        if let p = messagesField[text] {
            let palavras = p.components(separatedBy:" ")
            self.generatorBoxesMessage(palavras)
            for palavra in palavras {
                print(palavra)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let view = touches.first?.view else {
            return
        }
        if view.tag == 0 {
            guard let campo = uiTextField else {
                return
            }
            campo.resignFirstResponder()
        }
    }
}

