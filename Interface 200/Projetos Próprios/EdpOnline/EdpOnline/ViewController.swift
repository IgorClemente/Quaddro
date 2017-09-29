//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uiTapAbreMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
        ControllerLateralMenu.controller.viewControllerAtiva = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

