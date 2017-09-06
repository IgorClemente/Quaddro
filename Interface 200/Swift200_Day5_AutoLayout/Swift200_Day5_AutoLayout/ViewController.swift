//
//  ViewController.swift
//  Swift200_Day5_AutoLayout
//
//  Created by Swift on 02/09/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBOutlet var uiTodosOsFundos: [UIView]?

  let stream = RadioStream()
  
  @IBAction func tapTocaRock() {
    stream.change(toStation: .rock)
  }
  
  @IBAction func tapTocaPop() {
    stream.change(toStation: .pop)
  }
  
  @IBAction func tapTocaEcletica() {
    stream.change(toStation: .ecletic)
  }
  
  @IBAction func tapTocaDance() {
    stream.change(toStation: .dance)
  }
  
  @IBAction func tapAtualizaSelecao(_ sender:UIButton) {
   
    uiTodosOsFundos?.forEach {
      $0.layer.borderColor = UIColor.clear.cgColor
    }
    
    sender.superview?.layer.borderColor = UIColor.red.cgColor
    sender.superview?.layer.borderWidth = 2
  }
}

