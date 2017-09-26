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
        let menu = LateralMenuView(frame: self.view.frame)
        self.view.addSubview(menu)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

