//
//  ViewControllerSucess.swift
//  ColorPassword
//
//  Created by Igor Clemente on 08/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit


class attemptsController {

    private var tentativas:Int = 0
    
    func setAtt() -> Void {
        tentativas += 1
    }
    
    func getAtt() -> Int {
        return tentativas
    }
}

class ViewControllerSucess: UIViewController {

    @IBOutlet weak var uiTextSucess: UILabel?
    @IBOutlet weak var uiImageSucess: UIImageView?
    
    let imagemSucess = UIImage(named:"8698678.jpg")
    
    override func viewDidLoad() {
        
        uiImageSucess?.image = imagemSucess
        let sucessText = (uiTextSucess?.text ?? "")
        uiTextSucess?.text = sucessText + "\(attemps.getAtt())"
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
