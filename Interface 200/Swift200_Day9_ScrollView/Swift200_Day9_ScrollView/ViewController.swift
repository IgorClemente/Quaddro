//
//  ViewController.swift
//  Swift200_Day9_ScrollView
//
//  Created by Swift on 07/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    @IBOutlet weak var uiCenario: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        montaCenario(sender:UIButton())
    }
    
    func montaCenario(sender:UIButton) {
    
        guard let cenario = uiCenario else {
            return
        }
        
        if !cenario.subviews.isEmpty {
            cenario.subviews.forEach { imagem in
                imagem.removeFromSuperview()
            }
        }
        sender.removeFromSuperview()
        
        let linhas = 10
        let colunas = 10
        
        for l in 0...linhas {
            for c in 0...colunas {
                let foto = UIImageView()
                if l == 0 || c == 0 || c == 9 || l == 10 {
                    foto.frame  = CGRect(x:CGFloat(c*128),y:CGFloat(l*128),width:128,height:128)
                    foto.image  = UIImage(named:"tile\(arc4random_uniform(5)+15)")
                }else {
                    foto.frame = CGRect(x:CGFloat(c*128),y:CGFloat(l*128),width:128, height:128)
                    foto.image = UIImage(named:"tile\(arc4random_uniform(20))")
                }
                cenario.addSubview(foto)
            }
        }
        
        let localImagem = cenario.subviews[Int(arc4random_uniform(100))].center
        let gato = UIButton()
        gato.frame = CGRect(origin: CGPoint(x:localImagem.x+68.0,y:localImagem.y+68.0), size: CGSize(width: 128, height: 128))
        gato.setImage(UIImage(named:"mike"), for: .normal)
        gato.addTarget(self, action: #selector(montaCenario(sender:)), for: .touchUpInside)
        
        print("\(localImagem)")
        cenario.addSubview(gato)
    }
}

