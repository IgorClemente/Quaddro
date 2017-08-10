//
//  SegundoViewController.swift
//  MeuApp
//
//  Created by Swift on 05/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class SegundoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Hello World")
    
    let minhaView = UIView()
    minhaView.backgroundColor = UIColor.red
    minhaView.frame = CGRect(x: 10, y: 30, width: 300, height: 90)
    self.view.addSubview(minhaView) 
    
    let cores:[UIColor] = [UIColor.white,UIColor.yellow,UIColor.blue,UIColor.green,UIColor.purple,UIColor.red]
    let largura =  self.view.frame.size.width/CGFloat(cores.count)
    
    for (pos,cor) in cores.enumerated() {
      
      let MView = UIView()
      MView.backgroundColor = cor
      MView.frame = CGRect(x: largura * CGFloat(pos), y: 0, width: largura, height: 100)
      self.view.addSubview(MView)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let tela = storyboard?.instantiateViewController(withIdentifier: "terceira") else {
      return
    }
    self.present(tela, animated: true, completion: nil)
  }
}
