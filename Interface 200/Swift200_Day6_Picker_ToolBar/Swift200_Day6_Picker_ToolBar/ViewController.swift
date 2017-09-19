//
//  ViewController.swift
//  Swift200_Day6_Picker_ToolBar
//
//  Created by Swift on 16/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource,
        UIPickerViewDelegate{

    @IBOutlet weak var uiPao: UIImageView?
    @IBOutlet weak var uiRecheio: UIImageView?
    @IBOutlet weak var uiExtra: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        criarBarraDeTitulo(comVFL: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Picker datasource
   
    var opcoes = [
        ["Frances","Ciabatta","Sirio"],
        ["Frango","H.200g"],
        ["Cheedar","Prato","Salada"]
    ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return opcoes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // para coluna "component", quantos itens?
        return opcoes[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Um dos itens do picker foi selecionado
        // coluna -> Componente
        // linha  -> Row
        
        let aImagem = UIImage(named:"l\(component+1)_\(row)")
        
        print("l\(component+1)_\(row)")
        
        switch component {
            case 0:
                uiPao?.image = aImagem
            case 1:
                uiRecheio?.image = aImagem
            case 2:
                uiExtra?.image = aImagem
            default:
                break
        }
        return opcoes[component][row]
    }
    

    
    // View Code: a barra de title é feita programaticamente - Visual Formating Language
    func criarBarraDeTitulo(comVFL vfl:Bool) {
    
        let fundo              = UIView()
        fundo.backgroundColor  = .black
        fundo.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fundo)
        
        let titulo           = UILabel()
        titulo.textColor     = .white
        titulo.text          = "hamburgueria"
        titulo.font          = UIFont.systemFont(ofSize: 22, weight: 2.0)
        titulo.textAlignment = .center
        titulo.translatesAutoresizingMaskIntoConstraints = false
        fundo.addSubview(titulo)
        
        if !vfl {
            var limitadores:[NSLayoutConstraint] = []
                limitadores.append(contentsOf:[
                    NSLayoutConstraint(item: fundo, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
                ])
                
                limitadores.append(contentsOf:[
                    NSLayoutConstraint(item: fundo, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
                ])
            
                limitadores.append(contentsOf:[
                   NSLayoutConstraint(item: fundo, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)     
                ])
                
                limitadores.append(contentsOf:[
                   NSLayoutConstraint(item: fundo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64)     
                ])
                //: MARK
                // Se colocar nil no Item ele entende que é ele mesmo
                limitadores.append(contentsOf:[
                   NSLayoutConstraint(item: titulo, attribute: .leading, relatedBy: .equal, toItem: fundo, attribute: .leading, multiplier: 1.0, constant: 0)
                ])
                
                limitadores.append(contentsOf:[
                   NSLayoutConstraint(item: titulo, attribute: .trailing, relatedBy: .equal, toItem: fundo, attribute: .trailing, multiplier: 1.0, constant: 0)
                ])
            
                limitadores.append(contentsOf:[
                   NSLayoutConstraint(item: titulo, attribute: .bottom, relatedBy: .equal, toItem: fundo, attribute: .bottom, multiplier: 1.0, constant: -10)
                ])
            //:MARK
            NSLayoutConstraint.activate(limitadores)    //Ativando todas as contraints
        } else {
            // Nossas regras em VFL
            let regras = [
                "H:|-0-[fundo]-0-|","V:|-0-[fundo(==64)]",
                "H:|-10-[titulo]-10-|", "V:|-20-[titulo(==44)]"
            ]
            
            // Mapa de views
            let mapaViews   = ["fundo": fundo,"titulo": titulo]
            var limitadores = [NSLayoutConstraint]()
            
            for regra in regras {
                limitadores.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: regra, options: NSLayoutFormatOptions(), metrics: nil, views: mapaViews))
            }
            
            NSLayoutConstraint.activate(limitadores)
        }
    }


}

