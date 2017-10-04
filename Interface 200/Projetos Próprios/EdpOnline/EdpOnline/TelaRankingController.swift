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
    @IBOutlet weak var uiSpinnerActivity: UIActivityIndicatorView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let posicoes = posicoesDoRanking else {
            return
        }
        posicoes.forEach { posicao in
            posicao.isHidden = true
        }
        uiSpinnerActivity?.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let posicoes = posicoesDoRanking,
              let usuarios = RankingInfo() else {
            return
        }
        for (index,posicao) in posicoes.enumerated() {
            posicao.isHidden = false
            var count = 0
            posicao.subviews.enumerated().forEach { (i,p) in
                if let identificador = p.restorationIdentifier, let campo = p as? UILabel{
                    switch identificador {
                        case "\(index+1)_nome":
                            campo.text  = usuarios[index].nome
                        case "\(index+1)_pontos":
                            campo.text = "\(usuarios[index].pontos) pontos"
                    default:
                        break
                    }
                    count += 1
                }
            }
        }
        uiSpinnerActivity?.stopAnimating()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func tapCriarMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}
