//
//  DetalhesViewController.swift
//  Swift200_Day3_ImageView
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var uiNome: UILabel?
    @IBOutlet weak var uiTexto: UITextView?
    @IBOutlet weak var uiFoto: UIImageView?
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //arrendando a foto
      if let foto = uiFoto {
        let radius = foto.frame.size.width
        foto.layer.cornerRadius = radius/2
      }
    }
    
    @IBAction func tapFechar() {
        dismiss(animated: true, completion: nil)
    }
}
