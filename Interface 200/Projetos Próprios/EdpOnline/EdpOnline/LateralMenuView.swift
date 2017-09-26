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
        
        // Setup de todos os botões  - :MARK
        let imagemPerfil = UIImageView()
            imagemPerfil.frame = CGRect(x:19,y:40,width:80,height:80)
            imagemPerfil.clipsToBounds = true
            imagemPerfil.image = UIImage(named:"perfil-amostra")
            imagemPerfil.contentMode = .scaleAspectFill
            imagemPerfil.layer.cornerRadius = imagemPerfil.frame.width/2
        
        let botaoSettings = UIButton()
            botaoSettings.clipsToBounds = true
            botaoSettings.setImage(UIImage(named:"settings"), for: .normal)
            botaoSettings.contentMode = .scaleAspectFill
            botaoSettings.translatesAutoresizingMaskIntoConstraints = false
            botaoSettings.addTarget(self, action: #selector(tapAcionar), for: .touchUpInside)
        
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
            botaoRanking.addTarget(self, action: #selector(tapAcionar), for: .touchUpInside)
        
        let botaoPremios = UIButton()
            botaoPremios.clipsToBounds = true
            botaoPremios.setImage(UIImage(named:"favorite"), for: .normal)
            botaoPremios.layer.cornerRadius = botaoHomeRetorno.frame.width/2
            botaoPremios.translatesAutoresizingMaskIntoConstraints = false
            botaoPremios.addTarget(self, action: #selector(tapAcionar), for: .touchUpInside)
        
        menuPrincipal.addSubview(botaoHomeRetorno)
        menuPrincipal.addSubview(botaoRanking)
        menuPrincipal.addSubview(botaoPremios)
        menuPrincipal.addSubview(botaoSettings)
        menuPrincipal.addSubview(imagemPerfil)
        menuPrincipal.addSubview(imagemPerfil)
        fundoModal.addSubview(menuPrincipal)
        self.addSubview(fundoModal)
        
        
        // Regras Layout - VFL :MARK
        var limitadores = [NSLayoutConstraint]()
        let regrasLayoutButtons = [
            "H:|-47-[botaoHomeRetorno]-47-|",
            "V:|-192-[botaoHomeRetorno(==34)]",
            "H:|-43-[botaoRanking]-43-|",
            "V:|-270-[botaoRanking(==36)]",
            "H:|-46-[botaoPremios]-46-|",
            "V:|-350-[botaoPremios(==32)]",
            "H:|-47-[botaoSettings]-47-|",
            "V:[botaoSettings(==31)]-50-|"
        ]
        
        let mapViewsMenuItems = [
            "botaoHomeRetorno":botaoHomeRetorno,
            "botaoRanking": botaoRanking,
            "botaoPremios": botaoPremios,
            "botaoSettings": botaoSettings
        ]
    
        regrasLayoutButtons.forEach { regra in
            limitadores.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: regra, options: NSLayoutFormatOptions(), metrics: nil, views: mapViewsMenuItems))
        }
        NSLayoutConstraint.activate(limitadores)
        
        // Setup Animação :MARK
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
    
    func tapAcionar() {
        print("Botao Ranking Acionado")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
