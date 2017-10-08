//
//  TempoViewController.swift
//  Swift200_Day8_TableStack
//
//  Created by Swift on 30/09/17.
//  Copyright © 2017 quaddro. All rights reserved.
//

import UIKit

class TempoViewController: UIViewController {

    @IBOutlet weak var uiIcone: UILabel?
    @IBOutlet weak var uiTemp: UILabel?
    @IBOutlet weak var uiCidade: UILabel?
    @IBOutlet weak var uiCredito: UILabel?
    @IBOutlet weak var uiFundo: UIImageView?
    @IBOutlet weak var uiSpinner: UIActivityIndicatorView?

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let favorita    = App.compartilhado.dadosDaFavorita()
        uiCidade?.text  = favorita.nome
        uiFundo?.image  = UIImage(named: favorita.bg)
        uiCredito?.text = favorita.credito
        
        uiTemp?.text   = " "
        uiIcone?.text  = " "
        
        uiSpinner?.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let favorita = App.compartilhado.dadosDaFavorita()
        
        // busca os dados da internet
        guard let dados = forecast(forCity: favorita.code) else{
            return
        }
        
        uiIcone?.text = dados.icon
        
        if App.compartilhado.usarCelsius {
            uiTemp?.text = "\(dados.temp)ºC"
        }else{
            let imperialTemp = (dados.temp * 9)/5 + 32
            uiTemp?.text = "\(imperialTemp)ºF"
        }
        
        uiSpinner?.stopAnimating()
        
    }
}
