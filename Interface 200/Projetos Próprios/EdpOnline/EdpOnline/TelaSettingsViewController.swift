//
//  TelaSettingsViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 26/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TelaSettingsViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var uiTextFieldsSettings: [UITextField]?
    
    @IBOutlet weak var uiTextNomeCompleto: UITextField?
    @IBOutlet weak var uiTextFieldEmail: UITextField?
    @IBOutlet weak var uiTextFieldSenha: UITextField?
    @IBOutlet weak var uiTextFieldNumeroTelefone: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let camposText = self.uiTextFieldsSettings else {
            return
        }
        for campo in camposText {
            guard let identificadorCampo = campo.restorationIdentifier else {
                return
            }
            
            let fieldImagem   = UIImageView(frame: CGRect(x:10,y:0,width:20, height:20))
            fieldImagem.image = UIImage(named:"field\(identificadorCampo)")
            
            let view   = UIView()
            view.frame = CGRect(x:0,y:0,width:45,height:20)
            view.layer.borderColor = UIColor.clear.cgColor
            view.layer.borderWidth = 10
            
            view.addSubview(fieldImagem)
            campo.leftView     = view
            campo.leftViewMode = .always
        }
    
        guard let u = App.shared.getUserLogged() else {
            return
        }
        self.uiTextNomeCompleto?.text = (((u["nome"] as? String) ?? "") + " " + ((u["sobrenome"] as? String) ?? ""))
        self.uiTextFieldEmail?.text   = ((u["email"] as? String) ?? "")
        self.uiTextFieldSenha?.text   = "12345678"
        self.uiTextFieldNumeroTelefone?.text = ((u["numeroTelefone"] as? String) ?? "") 
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let campoNome  = uiTextNomeCompleto,
              let campoEmail = uiTextFieldEmail,
              let campoSenha = uiTextFieldSenha,
              let campoTelefone = uiTextFieldNumeroTelefone else {
            return true
        }
        let mapaCamposContinue:[UITextField:UITextField?] = [
            campoNome : campoEmail,
            campoEmail : campoSenha,
            campoSenha : campoTelefone,
            campoTelefone : nil
        ]
        
        if let proximoCampo = mapaCamposContinue[textField],
           let destino = proximoCampo {
           destino.becomeFirstResponder()
        }else {
           textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func tapAbrirMenuPrincipal(_ sender: UIButton) {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}
