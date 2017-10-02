//
//  TelaPremioController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 01/10/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TelaRankingController:UIViewController {
    
    @IBOutlet var posicoesDoRanking: [UIView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func tapCriarMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}
