//
//  LateralMenuView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 24/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


protocol controleDeMenu {
    var menuPrincipalControle:UIView? {get set}
}

class LateralMenuView : UIView, telaControlavel {

    var invocouControle: UIViewController?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let fundoModal   = UIView()
            fundoModal.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
            fundoModal.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            fundoModal.tag = 10
        
        let menuPrincipal = UIView()
            menuPrincipal.frame = CGRect(x:0,y:0,width:125,height:self.frame.height)
            menuPrincipal.backgroundColor = UIColor.white
        
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
            botaoSettings.addTarget(self, action: #selector(tapSettingsCreateMenu), for: .touchUpInside)
        
        let botaoHomeRetorno = UIButton()
            botaoHomeRetorno.clipsToBounds = true
            botaoHomeRetorno.setImage(UIImage(named:"home"), for: .normal)
            botaoHomeRetorno.layer.cornerRadius = botaoHomeRetorno.frame.width/2
            botaoHomeRetorno.translatesAutoresizingMaskIntoConstraints = false
        
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
            ,toItem: botaoRanking,attribute: .top,multiplier: 1.0,constant: -50)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal,attribute: .centerX, multiplier: 1.0,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width, multiplier: 0.3,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoHomeRetorno, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 1.0,constant:40)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoRanking,attribute: .centerY, relatedBy: .equal,toItem:
            menuPrincipal,attribute:
                .centerY,multiplier: 1,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoRanking,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoRanking, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.4,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item:botaoRanking, attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute, multiplier: 1.0, constant:48)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoPremios,attribute: .top, relatedBy: .equal,toItem:
                botaoRanking,attribute:
                .bottom,multiplier: 1,constant: 50)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.3,constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoPremios, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: 40)])
        
        limitadores.append(contentsOf:
            [NSLayoutConstraint(item: botaoSettings,attribute: .bottom, relatedBy: .equal,toItem:
                menuPrincipal,attribute:
                .bottom,multiplier:1.0,constant: -50)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings,attribute: .centerX,relatedBy: .equal,toItem: menuPrincipal, attribute: .centerX, multiplier: 1.0, constant: 0)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings, attribute: .width,relatedBy: .equal,toItem: menuPrincipal,attribute: .width,multiplier: 0.3,constant: 1)])
        
        limitadores.append(contentsOf:[NSLayoutConstraint(item: botaoSettings, attribute: .height,relatedBy: .equal,toItem: nil,attribute: .notAnAttribute, multiplier: 1.0, constant: 39)])
        
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
    
    @objc func tapSettingsCreateMenu() {
        
        let settingsTela = TelaSettingsViewController(nibName:"TelaSettingsViewController",bundle:nil)
        
        settingsTela.modalTransitionStyle = .crossDissolve
        settingsTela.modalPresentationStyle = .currentContext
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(settingsTela,animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
