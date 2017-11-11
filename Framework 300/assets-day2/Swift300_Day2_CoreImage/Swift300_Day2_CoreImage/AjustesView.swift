//
//  AjustesView.swift
//  Swift300_Day2_CoreImage
//
//  Created by Nilo on 10/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import CoreGraphics

@objc protocol AdjustsViewDelegate  {
    func adjustsDidChange()
}

class AdjustsView: UIView {

    @IBOutlet weak var delegate:AdjustsViewDelegate?
    
    var hue:CGFloat        = 0.0 { didSet{ setNeedsDisplay()} }
    var saturation:CGFloat = 0.0 { didSet{ setNeedsDisplay()} }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        
        // TODO-5.1) Mudar HUE (gestos)
        
        // 1) -  Cria a funcao que o gesto vai chamar
        // 2) -  Inicializa o reconhecedor e adiciona na view
        let escutaDeGestoParaBaixo       = UISwipeGestureRecognizer(target: self, action: #selector(gestoParaBaixo))
        escutaDeGestoParaBaixo.direction = .down
        
        let escutaDeGestoParaCima        = UISwipeGestureRecognizer(target: self, action: #selector(gestoParaCima))
        escutaDeGestoParaCima.direction  = .up
        
        let escutaDeGestoParaDireita        = UISwipeGestureRecognizer(target: self, action: #selector(gestoParaDireita))
        escutaDeGestoParaDireita.direction  = .right
        
        let escutaDeGestoParaEsquerda       = UISwipeGestureRecognizer(target: self, action: #selector(gestoParaEsquerda))
        escutaDeGestoParaEsquerda.direction = .left
        
        self.gestureRecognizers = [escutaDeGestoParaBaixo,escutaDeGestoParaCima,
                                   escutaDeGestoParaDireita,escutaDeGestoParaEsquerda]
    }
    
    @objc func gestoParaBaixo() {
        saturation -= 0.1
        saturation = max(saturation,-0.5)
        delegate?.adjustsDidChange()
    }
    
    @objc func gestoParaCima() {
        saturation += 0.1
        saturation = min(saturation,0.5)
        delegate?.adjustsDidChange()
    }
    
    @objc func gestoParaDireita() {
        hue += 0.1
        hue = min(hue,0.5)
        delegate?.adjustsDidChange()
    }
    
    @objc func gestoParaEsquerda() {
        hue -= 0.1
        hue = max(hue,-0.5)
        delegate?.adjustsDidChange()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let (w,h)   = (self.frame.size.width, self.frame.size.height)
        context?.addEllipse(in: CGRect(
            x: 2 + (hue + 0.5) * (w - 9),
            y: h - (2 + (saturation + 0.5) * (h - 9)),
            width: 5, height: 5))
        context?.setFillColor(UIColor.green.cgColor)
        context?.fillPath()

    }
    
}
