//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewSubMenuArvores: UIView?
    @IBOutlet weak var viewSubMenuMapa: UIView?
    @IBOutlet var botoesSubMenu: [UIBarButtonItem]?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botoesSubMenu?[0].tintColor = UIColor.gray
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
               UIView.animate(withDuration: 0.3,animations: {
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
               UIView.animate(withDuration: 0.3, animations: {
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

