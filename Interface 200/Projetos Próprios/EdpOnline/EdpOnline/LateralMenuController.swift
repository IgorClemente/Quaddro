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
    
    @objc func tapSettingsCreateMenu() {
        self.fecharMenuPrincipal()
        let settingsTela = TelaSettingsViewController(nibName:"TelaSettingsViewController",bundle:nil)
        
        settingsTela.modalTransitionStyle = .crossDissolve
        settingsTela.modalPresentationStyle = .currentContext
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(settingsTela,animated: true, completion: nil)
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
