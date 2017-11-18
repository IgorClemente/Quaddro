//
//  ViewController.swift
//  Swift300_Day3_2_AB
//
//  Created by Nilo on 18/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapB() {
        performSegue(withIdentifier: "show", sender: "B")
    }
    
    @IBAction func tapA() {
        performSegue(withIdentifier: "show", sender: "A")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ShowViewController else{
            return
        }
        
        switch (sender as? String) ?? "" {
        case "A": controller.chosen = .A
        case "B": controller.chosen = .B
        default: break
        }
        
    }
}

