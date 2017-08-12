//
//  ViewController.swift
//  Swift200_Day2_TextField
//
//  Created by Swift on 12/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var uiNomeField: UITextField?
  @IBOutlet weak var uiSobrenomeField: UITextField?
  @IBOutlet weak var uiEmailField: UITextField?
  @IBOutlet weak var uiSenhaField: UITextField?
  
  @IBOutlet var uiTodosCampos: [UITextField]?
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    let mapeamento:[UITextField:UITextField?] = [
      (uiNomeField ?? UITextField()) : uiSobrenomeField,
      (uiSobrenomeField ?? UITextField()) : uiEmailField,
      (uiEmailField ?? UITextField()) : uiSenhaField,
      (uiSenhaField ?? UITextField()) : nil
    ]
    
    if let valorDicionario = mapeamento[textField],
       let destino = valorDicionario {
       destino.becomeFirstResponder()
    }else {
       textField.resignFirstResponder()
    }
    
    return false
  }
  
  @IBAction func uiButtonLimpar() {
    guard let campos = self.uiTodosCampos else {
      return
    }
    for campo in campos {
        campo.text = "" 
    }
  }
  
  @IBAction func voltar(sender:UIStoryboardSegue) {
    print("Voltei")
    print(tudoPreenchido())
    mostrarAviso(comErro: "Error")
  }
                  
  func tudoPreenchido() -> Bool {
  
    guard let nome = self.uiNomeField,
      nome.text != "" else {
      return false
    }
    
    guard let idade = self.uiSobrenomeField,
      idade.text != "" else {
      return false
    }
    
    guard let email = self.uiEmailField,
      email.text != "" else {
      return false
    } 
    
    guard let senha = self.uiSenhaField,
      senha.text != "" else {
      return false
    }
    
    guard senha.text == "123" else {
      return false
    }
    
    return true
  }

  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    self.mostrarAviso(comErro: "Error")
    return true
  }
  
  
  func mostrarAviso(comErro erro:String) {
      print(erro)
      let alerta = Alerta(frame: self.view.frame) 
      self.view.addSubview(alerta)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

