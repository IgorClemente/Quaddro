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
    
    @IBOutlet weak var uiMessageLanguage: UILabel?
    @IBOutlet weak var uiTextField: UITextField?
    var AllFields:[UILabel] = [UILabel]()
    let boxMessages = UIView()
    
    var messagesAComparar = [String]()
    var messagesField:[String:String] = [
        "Olá do Igor":"Hello From Igor",
        "Esse é um cachorro":"It's a Dog",
        "Meu nome é Joana":"My name is Joana",
        "Paz e Amor":"Love and Peace"
    ]
    var messages:[String] = ["Olá do Igor","Esse é um cachorro","Meu nome é Joana","Paz e Amor"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boxMessages.frame = CGRect(x:16,y:420,width:288,height:128)
        self.boxMessages.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        self.prepareMessages()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !self.AllFields.isEmpty else {
            return
        }
        
        if let fieldEditing = textField.text {
           let textCompared = fieldEditing.components(separatedBy:" ")
            
           for campo in AllFields {
              if textCompared.contains(campo.text ?? "") {
                 let indexTextCompared = textCompared.index(of: campo.text ?? "")
                 let indexTextPalavras = self.messagesAComparar.index(of: campo.text ?? "")
                 campo.isHidden = (indexTextCompared == indexTextPalavras) ? true : false
              } else {
                 campo.isHidden = false
              }
           }
        }
        
        let next = AllFields.reduce(true,{ (campoAtivo,campo) in
            if campoAtivo {
                return campo.isHidden == true
            } else {
                return false
            }
        })
        
        if next {
            self.AllFields = []
            self.uiTextField?.text = ""
            self.prepareMessages()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
    
    func generatorBoxesMessage(_ words:[String]) -> Void {
        
        var gerados:[String] = words
        for (pos,_) in words.enumerated() {
            
            let idxShuffle = arc4random_uniform(UInt32(gerados.count))
            let widthBox = (self.view.frame.size.width+30)/CGFloat(words.count)
            
            let box = UILabel()
            box.frame = CGRect(x:widthBox * CGFloat(pos),y:10,width:50,height:50)
            box.backgroundColor = UIColor.white
            box.text = gerados[Int(idxShuffle)]
            box.textColor = UIColor.red
            box.textAlignment = .center
            
            self.AllFields.append(box)
            self.boxMessages.addSubview(box)
            gerados.remove(at:Int(idxShuffle))
        }
        self.view.addSubview(self.boxMessages)
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
            self.messagesAComparar = palavras
        }
    }
}

