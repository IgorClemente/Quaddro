//
//  App.swift
//  Swift200_Day4_SegmentStepperSwitch
//
//  Created by Swift on 26/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import Foundation
import UIKit

enum DiaDaSemana : String {
  case segunda, terca, quarta, quinta, sexta
  case sabado, domingo
}

class App { 
  
  static let compartilhado = App()
  private init(){ }

  // API -> Application public interface
  // são os métodos de apoio disponíveis no app inteiro
  
  func diaAtual() -> (nome:DiaDaSemana, indice:Int) {
      
      // Date é um formato imparcial de data ele não assume o formato brasileiro -> Gregoriano
      let hoje = Date()
      let calendario = Calendar(identifier: .gregorian)
      let diaDaSemana = calendario.component(.weekday, from: hoje)
      
      switch diaDaSemana {
        case 2: return (.segunda,1)
        case 3: return (.terca,2)
        case 4: return (.quarta,3)
        case 5: return (.quinta,4)
        case 6: return (.sexta,5)
        case 7: return (.sabado,6)
        default: return (.domingo,0)
      }
  }
  
  // User defaults guarda info do usuário entre seções
  // em outras palavras, ele salva no DISCO
  // Atenção: não guarde dados sigilosos sem criptografar
  let ud = UserDefaults.standard
  
  func definir(paraDia dia:DiaDaSemana, drinks:Int) {
      
      // Primeiro vou recuperar o que já tinha antes
      
    var jaSalvo:[String:Int] = ud.object(forKey:"drinks") as? [String:Int] ?? [:]
    
    // salvando o conteúdo novo
    jaSalvo[dia.rawValue] = drinks
    ud.set(jaSalvo, forKey:"drinks")
    
    // synchronize vai escrever no disco de maneira segura
    ud.synchronize()
  }
  
  // Recuperar: le do ud valores já salvos
  func recuperar(paraDia dia:DiaDaSemana) -> Int? {
    guard let dadosSalvos = ud.value(forKey: "drinks") as? [String:Int] else {
        return nil
    }
    
    return dadosSalvos[dia.rawValue]
  }

}
