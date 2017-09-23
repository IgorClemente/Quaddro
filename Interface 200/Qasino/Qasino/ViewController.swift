//
//  ViewController.swift
//  Qasino
//
//  Created by Swift on 23/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate,
                      UIPickerViewDataSource {

    @IBOutlet weak var uiMeuPicker: UIPickerView?
    
    @IBOutlet weak var uiBtnGiraUm: UIButton?
    @IBOutlet weak var uiBtnGiraDois: UIButton?
    @IBOutlet weak var uiBtnGiraTres: UIButton?
    
    let icones = ["🐨","🦁","🐯","🐒","🐴",
                  "🦏","🌏","🌝","🌖","🌳"] 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
       
        let daVez = icones[row]
        
        let meuTexto = UILabel()
        meuTexto.text = daVez
        meuTexto.font = UIFont.systemFont(ofSize: 38)
        meuTexto.textAlignment = .center
        meuTexto.backgroundColor = .white
        meuTexto.layer.cornerRadius = 5
        meuTexto.layer.borderWidth = 1
        meuTexto.layer.borderColor = UIColor.black.cgColor
        meuTexto.clipsToBounds = true
        
        return meuTexto
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapGira(_ sender: UIButton) {
        
    }

    @IBAction func giraTodos(_ sender: UIButton) {
        
    }
}

