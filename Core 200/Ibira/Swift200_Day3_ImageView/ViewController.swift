//
//  ViewController.swift
//  Swift200_Day3_ImageView
//
//  Created by Swift on 19/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func tapMapa() {
    
    let endereco = "https://maps.apple.com/?daddr=Parque+do+Ibirapuera"
    guard let url = URL(string: endereco) else {
      return
    }
    
    //Verifica se é possível entender esse endereço
    if UIApplication.shared.canOpenURL(url) { 
        UIApplication.shared.openURL(url)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("Ativei a segue \(segue.identifier ?? "")")
  
    guard let detalhes = segue.destination as? DetalhesViewController else{
      return
    }
    detalhes.opcaoEscolhida = segue.identifier
  }
}

