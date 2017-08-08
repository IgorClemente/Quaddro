//
//  ViewControllerSucess.swift
//  ColorPassword
//
//  Created by MACBOOK AIR on 07/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewControllerSucess: ViewController {

    @IBOutlet weak var uiSucessText: UILabel?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        let textSucess = uiSucessText?.text ?? ""
        uiSucessText?.text = "\(textSucess)\(89)"
        print(super.getAttemps())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let view = touches.first?.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
