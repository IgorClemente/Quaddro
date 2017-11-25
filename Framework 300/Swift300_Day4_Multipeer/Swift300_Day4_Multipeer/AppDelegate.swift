//
//  AppDelegate.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // TODO-17.1
    var task:UIBackgroundTaskIdentifier?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert],
                                            completionHandler: { _,_ in })
        return true
    }

    // TODO-17.2
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // Avisa o sistema que a gente tava no meio de um negócio
        // quando o app foi pra background 
        task = UIApplication.shared.beginBackgroundTask(expirationHandler: { 
            if let task = self.task {
                UIApplication.shared.endBackgroundTask(task)
            }
        })
        
        print("Em background")
        let tempoRestante = UIApplication.shared.backgroundTimeRemaining
        print("Faltam \(tempoRestante) segundos para morrer")
    }
}

