//
//  TelaSettingsViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 26/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TelaSettingsViewController : UIViewController {
    
    @IBOutlet var uiTextFieldsSettings: [UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let camposText = self.uiTextFieldsSettings else {
            return
        }
        for campo in camposText {
            guard let identificadorCampo = campo.restorationIdentifier else {
                return
            }
            let fieldImagem   = UIImageView(frame: CGRect(x:5,y:0,width:20, height:20))
            fieldImagem.image = UIImage(named:"field\(identificadorCampo)")
            let view   = UIView()
            view.frame = CGRect(x:0,y:0,width:25,height:20)
            view.addSubview(fieldImagem)
            campo.leftView     = view
            campo.leftViewMode = .always
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func tapAbrirMenuPrincipal(_ sender: UIButton) {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}
