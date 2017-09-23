//
//  ValidaIdadeViewController.swift
//  Swift200_Day7_DatePickerAlertView
//
//  Created by Swift on 23/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class ValidaIdadeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tapEntrar() {
        // Valida a idade
        performSegue(withIdentifier: "entrar", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
