//
//  ViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class HomeViewController: UIViewController {

    @IBOutlet weak var uiNickname:UITextField?
    @IBOutlet weak var uiJoinRoom:UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Desabilita o botão até que preencha o nick
        let hasText = !(uiNickname?.text?.isEmpty ?? true)
        updateTextfields(shouldHide: !hasText)
        if !hasText { uiNickname?.becomeFirstResponder() }
        
        // TODO-14
        app.desconectarTudo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Na troca de tela atualiza o nick preenchido
        app.meuNick = uiNickname?.text ?? ""
    }
}

extension HomeViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let old = (textField.text as NSString?) ?? ""
        let newText = old.replacingCharacters(in: range, with: string)
        updateTextfields(shouldHide:newText.isEmpty)
        return true
    }
    
    func textFieldShouldReturn(_ t:UITextField) -> Bool {
        uiNickname?.resignFirstResponder()
        return false
    }
    
    func updateTextfields(shouldHide:Bool){
        UIView.animate(withDuration: 0.3) {
            self.uiJoinRoom?.isEnabled   = !shouldHide
            self.uiJoinRoom?.alpha       = shouldHide ? 0.2 : 1.0
        }
    }
    
}

