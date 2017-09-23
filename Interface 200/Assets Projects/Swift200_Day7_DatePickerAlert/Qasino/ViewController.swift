//
//  ViewController.swift
//  Qasino
//
//  Created by Luiz Gustavo Lino on 10/21/16.
//  Copyright © 2016 Luiz Gustavo Lino. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var btnGiraUm: UIButton!
    @IBOutlet weak var btnGiraDois: UIButton!
    @IBOutlet weak var btnGiraTres: UIButton!
    
    @IBOutlet weak var meuPicker: UIPickerView!
    var giradasFaltando = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if let reuse = view {
            return reuse
            
        }else{
        
            let titulo = ["🌸","🌝","❄️","🍓","💝", "♣️", "🈷️", "🍐", "🐶", "😎"][row%10]
            
            let essaView = UILabel()
            essaView.text = titulo
            essaView.layer.cornerRadius = 5
            essaView.layer.borderColor  = UIColor.black.cgColor
            essaView.layer.borderWidth  = 1
            essaView.textAlignment      = .center
            essaView.backgroundColor    = UIColor.white
            essaView.clipsToBounds      = true
            
            return essaView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meuPicker.selectRow(15, inComponent: 0, animated: false)
        meuPicker.selectRow(15, inComponent: 1, animated: false)
        meuPicker.selectRow(15, inComponent: 2, animated: false)
        
        btnGiraUm.isEnabled = false
        btnGiraDois.isEnabled = false
        btnGiraTres.isEnabled = false
    }
    
    @IBAction func tapGira(_ sender: UIButton) {
        gira(rodinha:sender.tag)
        
        giradasFaltando -= 1
        if giradasFaltando == 0 {
            btnGiraUm.isEnabled = false
            btnGiraDois.isEnabled = false
            btnGiraTres.isEnabled = false
        }
    }
    
    func gira(rodinha:Int){
    
        let seleçãoOriginal = meuPicker.selectedRow(inComponent: rodinha)
        meuPicker.selectRow(10 + seleçãoOriginal%10, inComponent: rodinha, animated: false)
        
        let aleatorio = meuPicker.selectedRow(inComponent: rodinha) + 1 + Int(arc4random() % 10)
        meuPicker.selectRow(aleatorio, inComponent: rodinha, animated: true)
        
        validaIguais()
    }
    
    @IBAction func tapTrocaTodos(_ sender: UIButton) {
        
        gira(rodinha:0)
        gira(rodinha:1)
        gira(rodinha:2)
        
        giradasFaltando = 3
        
        btnGiraUm.isEnabled = true
        btnGiraDois.isEnabled = true
        btnGiraTres.isEnabled = true
        
    }
    
    
    func validaIguais(){
        if meuPicker.selectedRow(inComponent: 0) == meuPicker.selectedRow(inComponent: 1)
            && meuPicker.selectedRow(inComponent: 1) == meuPicker.selectedRow(inComponent: 2) {
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
    }
}

