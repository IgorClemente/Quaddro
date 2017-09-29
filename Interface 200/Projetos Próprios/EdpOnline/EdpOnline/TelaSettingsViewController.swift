//
//  TelaSettingsViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 26/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TelaSettingsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func tapAbrirMenuPrincipal(_ sender: UIButton) {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}
