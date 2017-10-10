//
//  ControllerLateralMenu.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 27/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class ControllerLateralMenu {
    
    init() {}
    static let controller = ControllerLateralMenu()
    
    var viewControllerAtiva:UIViewController?
    var viewControllerTransition:UIViewController?  = nil
    var menu:UIView?
    
    func criarMenuPrincipal(_ viewEndPoint:UIViewController) -> Void {
        self.menu = LateralMenuView(frame: viewEndPoint.view.frame)
        self.viewControllerAtiva = viewEndPoint
        viewEndPoint.view.addSubview(self.menu ?? UIView())
    }
    
    @objc func tapRetornoHome() {
        if let view = viewControllerAtiva{
            view.dismiss(animated: true, completion: nil)
            self.fecharMenuPrincipal()
        }
    }
    
    @objc func tapSettingsCreateTela() {
        self.fecharMenuPrincipal()
        let settingsTela = TelaSettingsViewController(nibName:"TelaSettingsViewController",bundle:nil)
        settingsTela.modalTransitionStyle = .crossDissolve
        settingsTela.modalPresentationStyle = .currentContext
        
        self.viewControllerTransition?.dismiss(animated: false, completion: nil)
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(settingsTela,animated: true, completion: nil)
        self.viewControllerTransition = settingsTela
    }
    
    @objc func tapRankingCreateTela() {
        self.fecharMenuPrincipal()
        let rankingTela = TelaRankingController(nibName:"TelaRankingController",bundle:nil)
        rankingTela.modalTransitionStyle = .crossDissolve
        rankingTela.modalPresentationStyle = .currentContext
        
        self.viewControllerTransition?.dismiss(animated: false, completion: nil)
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(rankingTela, animated: true, completion:nil)
        self.viewControllerTransition = rankingTela
    }
    
    @objc func tapPremiosCreateTela() {
        self.fecharMenuPrincipal()
        let premiosTela = TelaPremiosController(nibName:"TelaPremiosController",bundle:nil)
        premiosTela.modalTransitionStyle = .crossDissolve
        premiosTela.modalPresentationStyle = .currentContext
        
        self.viewControllerTransition?.dismiss(animated: false, completion: nil)
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(premiosTela,animated:true,completion:nil)
        self.viewControllerTransition = premiosTela
    }
    
    @objc func fecharMenuPrincipal() {
        guard let m = menu else {
            return
        }
        UIView.animate(withDuration: 0.4, animations: {
            m.alpha = 0.0
        }){ _ in
            m.removeFromSuperview()
        }
    }
}
