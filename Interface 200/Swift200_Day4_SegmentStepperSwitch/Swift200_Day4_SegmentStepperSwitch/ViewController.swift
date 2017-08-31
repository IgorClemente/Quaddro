//
//  ViewController.swift
//  Swift200_Day4_SegmentStepperSwitch
//
//  Created by Swift on 26/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var uiAllFields: [UIView]?
  @IBOutlet weak var uiSegmentoDiaDaSemana: UISegmentedControl?
  @IBOutlet weak var uiDrinksAtual: UILabel?
  @IBOutlet weak var uiCopo: UIView?
  
  @IBOutlet weak var uiMostraAdicional: UILabel?
  @IBOutlet weak var uiContador: UIStepper?
  
  
  var diaSelecionado:DiaDaSemana{
    let dias:[DiaDaSemana] = [
      .domingo, .segunda, .terca, .quarta, .quinta, .sexta
    ]
    return dias[uiSegmentoDiaDaSemana?.selectedSegmentIndex ?? 0]
  }
  
  @IBAction func uiStepper(_ sender: UIStepper) {
      
    let valor = Int(uiContador?.value ?? 0)
    uiMostraAdicional?.text = "+\(valor)"
    
  }
  
  @IBAction func tapRegistrar() {
    
    let quantidade = Int(uiContador?.value ?? 0)
    let atual      = Int(uiDrinksAtual?.text ?? "") ?? 0
    
    let soma = quantidade + atual
    App.compartilhado.definir(paraDia: diaSelecionado,drinks: soma)
    atualizarAtual()
    
  }
  
  func atualizarAtual() {
    
    let atual = App.compartilhado.recuperar(paraDia: diaSelecionado) ?? 0
    uiDrinksAtual?.text = "\(atual)"
    
    let perc    = Double(min(atual,6))/6.0
    let tamanho =  40 + (100 * perc)
    let posição =  140 + (150 - tamanho)
    
    UIView.animate(withDuration: 0.4) {
        self.uiCopo?.frame = CGRect(x: 41, y: posição,
                                    width: 68, height: tamanho)
    }
    
  }
  
  override var preferredStatusBarStyle:UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    guard let viewsRadius = uiAllFields else {
      return
    }
    
    for view in viewsRadius {
      view.layer.cornerRadius = 10
    }
    
    // Vamos testar o UD
    /*
    App.compartilhado.definir(paraDia: .terca, drinks: 4)
    let d = App.compartilhado.recuperar(paraDia: .terca)
    print(d)
    */
   
    let atual = App.compartilhado.diaAtual()
    if let segmentos = uiSegmentoDiaDaSemana {
      for indice in 0..<segmentos.numberOfSegments {
        if indice > atual.indice {
          segmentos.setEnabled(false, forSegmentAt: indice)
        }else {
          segmentos.setEnabled(true, forSegmentAt: indice)
          if indice == atual.indice {
            segmentos.selectedSegmentIndex = indice
          }
        }
      }
    }
    atualizarAtual()
  }
    
  
  @IBAction func uiMudaDiaSemana() {
        atualizarAtual()
  }
    
}

