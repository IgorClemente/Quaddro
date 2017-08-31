//
//  ViewController.swift
//  ColorPassword
//
//  Created by Igor Clemente on 05/08/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import Darwin


var attemps = attemptsController()


class ViewController: UIViewController {

  private var barColors:[UIColor] = [UIColor.blue,UIColor.red,UIColor.green,UIColor.purple,UIColor.yellow,UIColor.orange]
  private let passColor:[UIColor] = [UIColor.red,UIColor.purple,UIColor.orange]
   
    
  override func viewDidLoad() {
    super.viewDidLoad()

    for pos in (0...3) {
        let larguraBarra = self.view.frame.size.width/3
        let viewColors = UIView()
        viewColors.backgroundColor = UIColor.blue
        viewColors.tag = pos+1
        viewColors.frame = CGRect(x: larguraBarra*CGFloat(pos),y: 30,width: larguraBarra,height: 400)
        self.view.addSubview(viewColors)
    }
  }
  
  func setDefault() {
    for pos in (0..<3) {
      self.view.viewWithTag(pos+1)?.backgroundColor = UIColor.blue
    }
  }
  
  func shuffleColor(_ tagView:Int) {
    
    let indexShuffle = arc4random_uniform(UInt32(self.barColors.count))
    let corShuffle = self.barColors[Int(indexShuffle)]
    self.view.viewWithTag(tagView)?.backgroundColor = corShuffle
  }
    
  @IBAction func loginButton(_ sender: UIButton) {
    
    var senha = Array<UIColor>()
    var pass = Array<Bool>()
    
    for pos in (0..<3) {
        if let color = self.view.viewWithTag(pos+1)?.backgroundColor {
            senha.append(color)
        }
    }
    for (numero,cor) in senha.enumerated() {
        if cor == passColor[numero] {
            pass.append(true)
        }
    }

    if pass.count == 3 {
        guard let screen = storyboard?.instantiateViewController(withIdentifier:"sucessView") else {
            return
        }
        self.present(screen,animated: true,completion:nil)
    }else {
        attemps.setAtt()
        self.setDefault()
    }
  }
    
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let view = touches.first?.view else {
        return
    }
    
    guard view.tag != 0 else {
        return
    }
    self.shuffleColor(view.tag)
  }
}

