//
//  AppDelegate.swift
//  menes
//
//  Created by Swift on 16/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Preparando o app para receber push
        // Pedir autorização para um certo conjunto de funcionalidades
        // ex: Badge, Som
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (sucesso, falha) in
            if sucesso {
               DispatchQueue.main.async {
                 application.registerForRemoteNotifications()         
               } 
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, 
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         print("AQUI OH O TOKEN",deviceToken.description)
    }
}

