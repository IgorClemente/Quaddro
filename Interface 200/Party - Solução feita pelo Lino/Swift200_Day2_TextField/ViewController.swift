//
//  ViewController.swift
//  Swift200_Day2_TextField
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var uiNome: UITextField?
    @IBOutlet weak var uiIdade: UITextField?
    @IBOutlet weak var uiEmail: UITextField?
    @IBOutlet weak var uiSenha: UITextField?
    
    @IBOutlet var uiTodosCampos: [UITextField]?

    @IBAction func tapApagarTodos() {
        uiTodosCampos?.forEach{ $0.text = "" }
        uiNome?.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == uiNome {
            uiIdade?.becomeFirstResponder()
        }else if textField == uiIdade {
            uiEmail?.becomeFirstResponder()
        }else if textField == uiEmail {
            uiSenha?.becomeFirstResponder()
        }else if textField == uiSenha {
            uiSenha?.resignFirstResponder()
        }
        
        return false
    }
    
    // Ponto de volta
    @IBAction func voltando(segue:UIStoryboardSegue){
        tapApagarTodos()
    }
    
    
    // Validar se todos estão preenchidos
    
    func todosPrenchidos() -> Bool {
        
        guard let todos = uiTodosCampos else{
            return false
        }
        
        let algumVazio = todos.reduce(false, { (jaAcheiAlgumVazio, t) in
            if jaAcheiAlgumVazio {
                return true
            }else{
                let atualVazio = t.text == ""
                return atualVazio
            }
        })
        
        if algumVazio {
            mostraErro(comTexto: "Oooorra, faltou preencher umas coisas ai. Faz esse favor, preenche tudo direitinho, mew 👽")
            return false
        }
        
        // garantir idade > 18
        //guard Int(uiIdade?.text ?? "") ?? 0 >= 18 else{
          //  mostraErro(comTexto: "Poooxa, Lek, aqui não é matinê, mewww! Vaza, vai pela sombra 😎")
            //return false
        //}
        
        // garantir que a senha esta correta
       // guard uiSenha?.text == "123" else{
         //   mostraErro(comTexto: "Não beleza, vou fingir que não vi que você nem sabe onde tá. Tchau 🙄")
           // return false
        //}
        
        return true
        
    }
    
    
    // garantir que não entre na próxima tela
    // sem que todos campos estejam preenchidos corretamente
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        let tudoCerto = todosPrenchidos()
        return tudoCerto // tudo certo -> pode continuar
    }
    
    func mostraErro(comTexto texto:String) {
        let erro = AlertaView(frame: self.view.frame,
                              texto: texto)
        self.view.addSubview(erro)
    }
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

