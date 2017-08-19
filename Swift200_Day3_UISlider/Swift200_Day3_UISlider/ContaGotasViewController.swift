//
//  ContaGotasViewController.swift
//  Swift200_Day3_UISlider
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit


// Para quem utilizar o Picker precisa ter um método de trocar cor

protocol DaquelesQueMudamDeCor {
  func alteraCor(paraNovaCor cor:UIColor)
}


class ContaGotasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    var quemMeuChamou:DaquelesQueMudamDeCor?
      
    @IBOutlet weak var uiAmostra: UIView?
  
    @IBOutlet weak var uiSliderVermelho: UISlider?
    @IBOutlet weak var uiSliderVerde: UISlider?
    @IBOutlet weak var uiSliderAzul: UISlider?
  
    @IBOutlet weak var uiCampoVermelho: UITextField?
    @IBOutlet weak var uiCampoVerde: UITextField?
    @IBOutlet weak var uiCampoAzul: UITextField?
    
    
    @IBAction func tapCancelar() {
      // dismiss -> Volta pra tela anterior
      dismiss(animated: true, completion: nil)
    }
  
    
    @IBAction func tapAplicar(_ sender: UIButton) {
        quemMeuChamou?.alteraCor(paraNovaCor: uiAmostra?.backgroundColor ?? UIColor.white)
    }
  
    @IBAction func sliderMudou(_ sender: Any) {
    
      // Vamos extrair cada canal de cor dos Slideres
      let vermelho = CGFloat(uiSliderVermelho?.value ?? 0)
      let verde = CGFloat(uiSliderVerde?.value ?? 0)
      let azul = CGFloat(uiSliderAzul?.value ?? 0)
    
      // Criar uma nova cor com a configuração atual
    
      let novaCor = UIColor(red: vermelho,
                            green: verde,
                            blue: azul,
                            alpha: 1.0)
      // Atualizando campos de texto
      uiAmostra?.backgroundColor = novaCor
      
      // Atualizando campos de texto
      uiCampoVermelho?.text = "\(Int(vermelho*255))"
      uiCampoAzul?.text = "\(Int(azul*255))"
      uiCampoVerde?.text = "\(Int(verde*255))"
  }
  
  
  func definirCor(_ cor: UIColor) {
      
      // atualizar a cor da amostra
      uiAmostra?.backgroundColor = cor
    
      // Mudar o sistemas e cores
      let ci = CIColor(color: cor)
    
      // atualizar sliders
      let vermelho = ci.red
      let verde    = ci.green
      let azul     = ci.blue
    
      uiCampoVermelho?.text = "\(Int(vermelho * 255))"
      uiCampoVerde?.text = "\(Int(verde * 255))"
      uiCampoAzul?.text = "\(Int(azul * 255))"
      
      uiSliderVermelho?.value = Float(vermelho)
      uiSliderVerde?.value = Float(verde)
      uiSliderAzul?.value = Float(azul)
  }
}
