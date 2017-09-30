//
//  ViewController.swift
//  Swift200_Day7_DatePickerAlertView
//
//  Created by Swift on 23/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController,
                UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var uiMeuPicker: UIPickerView?
    @IBOutlet weak var uiBtnGiraUm: UIButton?
    @IBOutlet weak var uiBtnGiraDois: UIButton?
    @IBOutlet weak var uiBtnGiraTres: UIButton?
    
    var tentativasFaltando = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiMeuPicker?.selectRow(25, inComponent: 0, animated: false)
        uiMeuPicker?.selectRow(25, inComponent: 1, animated: false)
        uiMeuPicker?.selectRow(25, inComponent: 2, animated: false)
    }
    
    let icones = ["🐶", "🐯", "🐮", "🐹", "🐰",
                  "🦊", "🐻", "🐼", "🐨", "🦁"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 41
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let daVez = icones[row%10]
        
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    
    @IBAction func tapGira(_ sender: UIButton) {
        
        gira(rodinha: sender.tag-1)
        
        tentativasFaltando -= 1
        if tentativasFaltando == 0 {
            uiBtnGiraUm?.isEnabled = false
            uiBtnGiraDois?.isEnabled = false
            uiBtnGiraTres?.isEnabled = false
        }
        validaTodosIguais()
    }
    
    @IBAction func tapGiraTodos() {
        gira(rodinha: 0)
        gira(rodinha: 1)
        gira(rodinha: 2)
        
        if tentativasFaltando == 0 {
            tentativasFaltando = 3
            uiBtnGiraUm?.isEnabled = true
            uiBtnGiraDois?.isEnabled = true
            uiBtnGiraTres?.isEnabled = true
        }
        validaTodosIguais()
    }
    
    
    
    func gira(rodinha:Int) {
        
        guard let picker = uiMeuPicker else {
            return
        }
        
        // antes de girar, vamos alinhar o picker na casa dos 30
        let iconeAtual = picker.selectedRow(inComponent: rodinha)%10 
        picker.selectRow(iconeAtual+30, inComponent: rodinha, animated: false)
        
        // Qual row ??
        // Primeiro sorteia um número de 1 até 10
        let sorteado = Int(arc4random()%10)
        let atual    = picker.selectedRow(inComponent: rodinha)
        let novo     = atual - sorteado - 1
        
        picker.selectRow(novo, inComponent: rodinha, animated: true)
    }
    
    func validaTodosIguais() {
        
        guard let picker = uiMeuPicker else {
            return
        }
        
        let primeiro = picker.selectedRow(inComponent: 0)%10
        let segundo  = picker.selectedRow(inComponent: 1)%10
        let terceiro = picker.selectedRow(inComponent: 2)%10 
        
        if primeiro == segundo && segundo == terceiro {
            print("Acertou")
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

