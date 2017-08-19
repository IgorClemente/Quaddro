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
  
    var worlds:[String] = [""]
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
        
        guard let t = self.uiMessageLanguage,
              let textCompare = messagesField[t.text ?? ""] else {
            return
        }
      
        let text = textCompare.components(separatedBy:" ")
        for txt in text {
            if txt == 
        }
    }
    
    
    func generatorBoxesMessage(_ worlds:[String]) -> Void {
        guard let campos = uiTodosCampos else {
            return
        }
        
        let widthBox = self.view.frame.size.width/CGFloat(worlds.count)
      
        var gerados:[String] = worlds
        for (_,campo) in campos.enumerated() {
            let idxShuffle = arc4random_uniform(UInt32(gerados.count))
            let labelText = UILabel()
            labelText.frame = CGRect(x:,y:,width:,height:)
          
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
            let worlds = p.components(separatedBy:" ")
            self.generatorBoxesMessage(worlds)
            self.worlds = worlds
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

