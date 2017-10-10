//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uiStackViewArvores: UIStackView?
    @IBOutlet weak var viewSubMenuArvores: UIView?
    @IBOutlet weak var viewSubMenuMapa: UIView?
    @IBOutlet var botoesSubMenu: [UIBarButtonItem]?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let botoes = botoesSubMenu,
              let subArvores = viewSubMenuArvores,
              let subMapa = viewSubMenuMapa else {
            return
        }
        for (index,botao) in botoes.enumerated() {
            if index == 0 {
                botao.tintColor = UIColor.gray
                subArvores.isHidden = false
                subMapa.isHidden = true
            }
        }
        createMenuArvores()
    }
    
    @IBAction func uiTapAbreMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
    
    @IBAction func tapSubMenu(_ sender: UIBarButtonItem) {
        guard let botoes  = botoesSubMenu,
              let viewSubMapa = viewSubMenuMapa,
              let viewSubArvore = viewSubMenuArvores else {
            return
        }
        if let titulo = sender.title {
          switch titulo {
            case "submenuMapa":
               UIView.animate(withDuration: 0.2,animations: {
                    viewSubMapa.alpha    = 1.0
               }){ _ in viewSubMapa.isHidden = false }
               for botao in botoes {
                 if botao.title == "submenuArvores" {
                    UIView.animate(withDuration: 0.3, animations: {
                      viewSubArvore.alpha = 0.0
                    }){ _ in
                      botao.tintColor = UIColor.gray
                      viewSubArvore.isHidden = true
                    }
                 } else {
                        botao.tintColor = UIColor.white
                 }
               }
            case "submenuArvores":
               UIView.animate(withDuration: 0.2, animations: {
                 viewSubArvore.alpha    = 1.0
               }){ _ in viewSubArvore.isHidden = false }
               for botao in botoes {
                 if botao.title == "submenuMapa" {
                    UIView.animate(withDuration: 0.3, animations: {
                      viewSubMapa.alpha = 0.0
                    }){ _ in
                      botao.tintColor = UIColor.gray
                      viewSubMapa.isHidden = true
                    }
                 } else {
                        botao.tintColor = UIColor.white
                 }
               }
            default:
               break
           }
        }
    }
    
    @IBAction func tapTiraFoto() {
        self.tirarFoto()
    }

    func createMenuArvores() {
        guard let stackArvores = self.uiStackViewArvores else {
            return
        }
        var limitadoresRegras = [NSLayoutConstraint]()
        let comprimentoViewArvores = self.view.frame.width
        
        for arvore in 0...10 {
            let arvoreItem   = UIView()
            arvoreItem.frame = CGRect(x:0,y:CGFloat(arvore*101),width:comprimentoViewArvores,height:100)
            arvoreItem.backgroundColor = UIColor(white:1,alpha:0.9)
            
            let  fotoArvore   = UIImageView()
            fotoArvore.frame  = CGRect(x:0,y:0,width:60,height:60)
            fotoArvore.image  = UIImage(named:"arvore-fio-demo")
            fotoArvore.contentMode = .scaleAspectFill
            fotoArvore.layer.cornerRadius = fotoArvore.frame.width/2
            fotoArvore.clipsToBounds = true
          
            let tituloArvore   = UILabel()
            tituloArvore.frame = CGRect(x:105,y:23,width:100,height:30)
            tituloArvore.font  = UIFont.systemFont(ofSize: 18)
            tituloArvore.textColor = UIColor.black
            tituloArvore.text = "Arvore"
            
            let regiaoArvore   = UILabel()
            regiaoArvore.frame = CGRect(x:105,y:45,width:100,height:30)
            regiaoArvore.font  = UIFont.preferredFont(forTextStyle: UIFontTextStyle("light"))
            regiaoArvore.font  = UIFont.systemFont(ofSize: 15)
            regiaoArvore.textColor = UIColor.gray
            regiaoArvore.text = "Guarulhos, SP"
            
            let pontuacaoArvore   = UILabel()
            pontuacaoArvore.frame = CGRect(x:270,y:37,width:100,height:30)
            pontuacaoArvore.font  = UIFont.preferredFont(forTextStyle: UIFontTextStyle("light"))
            pontuacaoArvore.font  = UIFont.systemFont(ofSize: 16)
            pontuacaoArvore.textColor = UIColor.black
            pontuacaoArvore.text  = "150 Pontos"
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.leading, relatedBy:.equal, toItem:arvoreItem, attribute:.leading, multiplier:1.0, constant:20)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.centerY, relatedBy:.equal, toItem:arvoreItem, attribute:.centerY, multiplier:1.0, constant:0)])
            
            arvoreItem.addSubview(pontuacaoArvore)
            arvoreItem.addSubview(tituloArvore)
            arvoreItem.addSubview(regiaoArvore)
            arvoreItem.addSubview(fotoArvore)
            stackArvores.addSubview(arvoreItem)
        }
        
        NSLayoutConstraint.activate(limitadoresRegras)
    }
    
    func tirarFoto() {
        if
     UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagemCapturada = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imagemData = UIImagePNGRepresentation(imagemCapturada)
            let imagemComprimida = UIImage(data: imagemData ?? Data())
            UIImageWriteToSavedPhotosAlbum(imagemComprimida ?? UIImage(), nil, nil, nil)

            picker.dismiss(animated: true, completion: nil)
            let alerta = UIAlertController(title:"Salvo", message:"Imagem Salva com Sucesso !", preferredStyle: .alert)
            let confirmaAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alerta.addAction(confirmaAction)
            self.present(alerta, animated: true, completion: nil)
        }
    }
}

