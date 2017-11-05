//
//  ViewController.swift
//  Swift300_Day1_Maps
//

import UIKit

class SystemLoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app.loadGeolocationData { success in 
            if success{
                self.swapToHome()
            }
        }
    }
    
    func swapToHome(){
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "map") else{
            return
        }
        self.navigationController?.setViewControllers([controller], animated: true)
    }
    
}

