//
//  LateralMenuView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 24/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class LateralMenuView:UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let fundoModal   = UIView()
        fundoModal.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
        fundoModal.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let menuPrincipal = UIView()
        menuPrincipal.frame = CGRect(x:0,y:0,width:125,height:self.frame.height)
        menuPrincipal.backgroundColor = UIColor.white
        
        let imagemPerfil = UIImageView()
        imagemPerfil.frame = CGRect(x:19,y:40,width:80,height:80)
        imagemPerfil.clipsToBounds = true
        imagemPerfil.image = UIImage(named:"perfil-amostra")
        imagemPerfil.contentMode = .scaleAspectFill
        imagemPerfil.layer.cornerRadius = imagemPerfil.frame.width/2
        
        let botaoPerfil = UIButton()
        botaoPerfil.frame = CGRect(x:19,y:40,width:80,height:80)
        botaoPerfil.clipsToBounds = true
        botaoPerfil.layer.cornerRadius = botaoPerfil.frame.width/2
        
        let botaoHomeRetorno = UIButton()
        botaoHomeRetorno.clipsToBounds = true
        botaoHomeRetorno.setImage(UIImage(named:"home"), for: .normal)
        botaoHomeRetorno.layer.cornerRadius = botaoHomeRetorno.frame.width/2
        botaoHomeRetorno.translatesAutoresizingMaskIntoConstraints = false
        botaoHomeRetorno.addTarget(self, action: #selector(tapFecharMenuPrincipal), for: .touchUpInside)
        
        let botaoRanking = UIButton()
        botaoRanking.clipsToBounds = true
        botaoRanking.setImage(UIImage(named:"ranking"), for: .normal)
        botaoRanking.layer.cornerRadius = botaoHomeRetorno.frame.width/2
        botaoRanking.translatesAutoresizingMaskIntoConstraints = false
        
        let botaoPremios = UIButton()
        botaoPremios.clipsToBounds = true
        botaoPremios.setImage(UIImage(named:"favorite"), for: .normal)
        botaoPremios.layer.cornerRadius = botaoHomeRetorno.frame.width/2
        botaoPremios.translatesAutoresizingMaskIntoConstraints = false
        
        var limitadores = [NSLayoutConstraint]()
        let regrasLayoutButtons = [
        "H:|-28-[botaoHomeRetorno]-28-|","V:|-64-[botaoHomeRetorno(==64)]"
       ]
        let mapViewsMenuItems = ["botaoHomeRetorno":botaoHomeRetorno]
    
        regrasLayoutButtons.forEach { regra in
            limitadores.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: regra, options: NSLayoutFormatOptions(), metrics: nil, views: mapViewsMenuItems))
        }
        NSLayoutConstraint.activate(limitadores)
        
        menuPrincipal.addSubview(botaoHomeRetorno)
        menuPrincipal.addSubview(botaoRanking)
        menuPrincipal.addSubview(botaoPremios)
        menuPrincipal.addSubview(imagemPerfil)
        menuPrincipal.addSubview(botaoPerfil)
        fundoModal.addSubview(menuPrincipal)
        self.addSubview(fundoModal)
        
        self.alpha = 0.0
        let centroAntes = CGPoint(x:menuPrincipal.center.x - 125,y:menuPrincipal.center.y)
        let centroFinal = menuPrincipal.center
        
        menuPrincipal.alpha = 0.0
        menuPrincipal.center = centroAntes
        
        UIView.animate(withDuration: 0.4){ _ in
            self.alpha = 1.0
            menuPrincipal.alpha = 1.0
            menuPrincipal.center = centroFinal
        }
    }
    
    func tapFecharMenuPrincipal() -> Void {
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0.0
        }){ _ in
            self.removeFromSuperview()
        }
    }
    
    func posicionar(Elementos elementos:[UIView]) -> Void {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
