//
//  LateralMenuView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 24/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class LateralMenuView : UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        let controladorMenu = ControllerLateralMenu.controller
        
        let fundoModal   = UIView()
            fundoModal.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
            fundoModal.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            fundoModal.tag = 10
        
        let menuPrincipal = UIView()
            menuPrincipal.frame = CGRect(x:0,y:0,width:125,height:self.frame.height)
            menuPrincipal.backgroundColor = UIColor.white
        
        let imagemPerfil = UIImageView()
            imagemPerfil.frame = CGRect(x:20,y:30,width:90,height:90)
            imagemPerfil.clipsToBounds = true
            imagemPerfil.image = UIImage(named:"perfil-amostra")
            imagemPerfil.contentMode = .scaleAspectFill
            imagemPerfil.layer.cornerRadius = imagemPerfil.frame.width/2
        
        let botaoSettings = UIButton()
            botaoSettings.clipsToBounds = true
            botaoSettings.setImage(UIImage(named:"settings"), for: .normal)
            botaoSettings.contentMode = .scaleAspectFill
            botaoSettings.translatesAutoresizingMaskIntoConstraints = false
            botaoSettings.addTarget(controladorMenu, action: #selector(controladorMenu.tapSettingsCreateTela), for: .touchUpInside)
        
        let botaoHomeRetorno = UIButton()
            botaoHomeRetorno.clipsToBounds = true
            botaoHomeRetorno.setImage(UIImage(named:"home"), for: .normal)
            botaoHomeRetorno.layer.cornerRadius = botaoHomeRetorno.frame.width/2
            botaoHomeRetorno.translatesAutoresizingMaskIntoConstraints = false
            botaoHomeRetorno.addTarget(controladorMenu, action: #selector(controladorMenu.tapRetornoHome), for: .touchUpInside)
        
        let botaoRanking = UIButton()
            botaoRanking.clipsToBounds = true
            botaoRanking.setImage(UIImage(named:"ranking"), for: .normal)
            botaoRanking.layer.cornerRadius = botaoHomeRetorno.frame.width/2
            botaoRanking.translatesAutoresizingMaskIntoConstraints = false
            botaoRanking.addTarget(controladorMenu, action: #selector(controladorMenu.tapRankingCreateTela), for: .touchUpInside)
        
        let botaoPremios = UIButton()
            botaoPremios.clipsToBounds = true
            botaoPremios.setImage(UIImage(named:"favorite"), for: .normal)
            botaoPremios.layer.cornerRadius = botaoHomeRetorno.frame.width/2
            botaoPremios.translatesAutoresizingMaskIntoConstraints = false
            botaoPremios.addTarget(controladorMenu,action:
            #selector(controladorMenu.tapPremiosCreateTela),for:.touchUpInside)
        
        menuPrincipal.addSubview(botaoHomeRetorno)
        menuPrincipal.addSubview(botaoRanking)
        menuPrincipal.addSubview(botaoPremios)
        menuPrincipal.addSubview(botaoSettings)
        menuPrincipal.addSubview(imagemPerfil)
        menuPrincipal.addSubview(imagemPerfil)
        fundoModal.addSubview(menuPrincipal)
        self.addSubview(fundoModal)
        
        var limitadores = [NSLayoutConstraint]()
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .bottom,relatedBy: .equal
            ,toItem: botaoRanking,attribute: .top,multiplier: 1.0,constant: -55)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal,attribute: .centerX, multiplier: 1.0,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width, multiplier: 0.4,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 1,constant:47)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoRanking,attribute: .centerY, relatedBy: .equal,toItem:
            menuPrincipal,attribute:
                .centerY,multiplier: 1,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoRanking,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoRanking, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.4,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item:botaoRanking, attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute, multiplier: 1.0, constant:50)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoPremios,attribute: .top, relatedBy: .equal,toItem:
                botaoRanking,attribute:
                .bottom,multiplier: 1,constant: 50)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.4,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: 50)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoSettings,attribute: .bottom, relatedBy: .equal,toItem:
                menuPrincipal,attribute:
                .bottom,multiplier:1.0,constant: -50)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.8,constant: 5)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 0.8, constant: 60)])
        
        NSLayoutConstraint.activate(limitadores)
        
        self.alpha = 0.0
        let centroAntes = CGPoint(x:menuPrincipal.center.x - 125,y:menuPrincipal.center.y)
        let centroFinal = menuPrincipal.center
        
        menuPrincipal.alpha = 0.0
        menuPrincipal.center = centroAntes
        
        UIView.animate(withDuration: 0.4){
            self.alpha = 1.0
            menuPrincipal.alpha = 1.0
            menuPrincipal.center = centroFinal
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            if t.view?.tag == 10 {
                UIView.animate(withDuration: 0.4, animations: {
                    self.alpha = 0.0
                }){ _ in
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
