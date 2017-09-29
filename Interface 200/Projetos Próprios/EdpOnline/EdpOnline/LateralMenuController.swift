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
        menu = LateralMenuView(frame: viewEndPoint.view.frame)
        viewEndPoint.view.addSubview(menu ?? UIView())
    }
    
    @objc func tapRetornoHome() {
        if let view = viewControllerAtiva, let menu = self.menu {
            view.dismiss(animated: true, completion: nil)
            menu.removeFromSuperview()
        }
    }
    
    @objc func tapSettingsCreateMenu() {
        let settingsTela = TelaSettingsViewController(nibName:"TelaSettingsViewController",bundle:nil)
        
        settingsTela.modalTransitionStyle = .crossDissolve
        settingsTela.modalPresentationStyle = .currentContext
        let tela = UIApplication.shared.keyWindow?.rootViewController
        tela?.present(settingsTela,animated: true, completion: nil)
    }
}
