//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uiTapAbreMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
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

