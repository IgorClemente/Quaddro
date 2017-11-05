//
//  DetalhesViewController.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    var person:Person?
    
    @IBOutlet weak var uiFotinha:WebImageView?
    @IBOutlet var uiRostinhos:[RostinhoButton]?
    
    @IBAction func tapVisitar(_ sender: UIButton) {
        if let endereco = person?.contact {
            UIApplication.shared.open(endereco, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tapApagar(_ sender: UIButton) {
        // remove a pessoa da lista e volta a tela
        person?.remove()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = person?.name ?? ""
        
        self.uiFotinha?.url = person?.pic 
        
        for rostinho in uiRostinhos ?? [] {
            rostinho.pessoa = person
        }
    }
}
