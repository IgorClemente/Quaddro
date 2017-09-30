//
//  ValidaIdadeViewController.swift
//  Swift200_Day7_DatePickerAlertView
//
//  Created by Swift on 23/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit


class ValidaIdadeViewController: UIViewController {

    @IBOutlet weak var pickerDateIdade: UIDatePicker?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pickerDateIdade?.maximumDate = Date()
    }

    @IBAction func tapEntrar() {
        
        guard let picker = pickerDateIdade else {
            return
        }
        
        let dataSelecionada = picker.date
        let dataAtual       = Date()
        let componente      = picker.calendar.dateComponents([.year], from: dataSelecionada, to: dataAtual)
        
        guard let idade = componente.year else {
            return
        }
        
        if idade >= 18 {
            performSegue(withIdentifier: "entrar", sender: nil)
        } else {
            // 1) Cria alerta definindo titulo e texto
            let aviso = UIAlertController(title: "Ops !",
                                          message: "Voce precisa ser mais velho que o Lucas para entrar em casinos",
                                          preferredStyle: .actionSheet)
            // 2) Quais botões ele tem
            let fechar = UIAlertAction(title: "Entendi", style: .default, handler: { _ in
                aviso.dismiss(animated: true, completion: nil)
            })
            aviso.addAction(fechar)
            
            // 3) Exibir o alerta
            self.present(aviso, animated: true, completion: nil)
        }
    }
}
