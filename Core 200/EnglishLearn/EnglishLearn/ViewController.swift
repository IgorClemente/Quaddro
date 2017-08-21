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
   
    @IBOutlet var uiAllFields: [UILabel]?
    @IBOutlet weak var uiMessageLanguage: UILabel?
    @IBOutlet weak var uiTextField: UITextField?
    
    var messagesAComparar = [String]()
    var messagesField:[String:String] = [
        "Olá do Igor":"Hello From Igor",
        "Esse é um cachorro":"It's a Dog"
    ]
    var messages:[String] = ["Olá do Igor","Esse é um cachorro"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareMessages()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let allFields = self.uiAllFields else {
            return
        }
        if let fieldEditing = textField.text {
           let textCompared = fieldEditing.components(separatedBy:" ")
            
           for (_,campo) in allFields.enumerated() {
              if textCompared.contains(campo.text ?? "") {
                 let indexTextCompared = textCompared.index(of: campo.text ?? "")
                 let indexTextPalavras = self.messagesAComparar.index(of: campo.text ?? "")
                 campo.isHidden = (indexTextCompared == indexTextPalavras) ? true : false
              } else {
                 campo.isHidden = false
              }
           }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    
    func generatorBoxesMessage(_ worlds:[String]) -> Void {
        guard let campos = self.uiAllFields else {
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
        guard let fieldText = uiMessageLanguage,
              let allFields = uiAllFields else {
            return
        }
        
        let idxShuffle = arc4random_uniform(UInt32(messages.count))
        let text = messages[Int(idxShuffle)]
        fieldText.text = text
        
        if let p = messagesField[text] {
            let palavras = p.components(separatedBy:" ")
            self.generatorBoxesMessage(palavras)
            self.messagesAComparar = palavras
        }
    }
}

