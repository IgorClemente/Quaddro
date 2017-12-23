//
//  TelaSettingsViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 26/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TelaSettingsViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uiScrollViewForm: UIScrollView?
    @IBOutlet var uiTextFieldsSettings: [UITextField]?
    
    @IBOutlet weak var uiTextNomeCompleto: UITextField?
    @IBOutlet weak var uiTextFieldEmail: UITextField?
    @IBOutlet weak var uiTextFieldSenha: UITextField?
    @IBOutlet weak var uiTextFieldNumeroTelefone: UITextField?
    @IBOutlet weak var uiUserPhoto: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let camposText = self.uiTextFieldsSettings else {
            return
        }
        
        for campo in camposText {
            guard let identificadorCampo = campo.restorationIdentifier else {
                return
            }
            
            let fieldImagem = UIImageView(frame: CGRect(x:10, y:0, width:20, height:20))
            fieldImagem.image = UIImage(named:"field\(identificadorCampo)")
            
            let view   = UIView()
            view.frame = CGRect(x:0, y:0, width:45, height:20)
            view.layer.borderColor = UIColor.clear.cgColor
            view.layer.borderWidth = 10
            
            view.addSubview(fieldImagem)
            campo.leftView     = view
            campo.leftViewMode = .always
        }
    
        App.shared.getUserLogged { (info) in
            guard let u = info else {
                return
            }
            
            self.uiTextNomeCompleto?.text = "\(u.first_name) \(u.last_name)"
            self.uiTextFieldEmail?.text   = "\(u.email_account)"
            self.uiTextFieldSenha?.text   = "12345678"
            self.uiTextFieldNumeroTelefone?.text = "\(u.number_phone)"
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let campoNome  = uiTextNomeCompleto,
              let campoEmail = uiTextFieldEmail,
              let campoSenha = uiTextFieldSenha,
              let campoTelefone = uiTextFieldNumeroTelefone else {
              return true
        }
        
        let mapaCamposContinue:[UITextField:UITextField?] = [
            campoNome : campoEmail,
            campoEmail : campoSenha,
            campoSenha : campoTelefone,
            campoTelefone : nil
        ]
        
        if let proximoCampo = mapaCamposContinue[textField],
           let destino = proximoCampo {
           destino.becomeFirstResponder()
        }else{
           textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func tapSaveInformationUser(_ sender: UIButton) {
        
        guard let fieldName = self.uiTextNomeCompleto,
              let fieldEmailAccount = self.uiTextFieldEmail,
              let fieldPassword     = self.uiTextFieldSenha,
              let fieldPhoneNumber  = self.uiTextFieldNumeroTelefone
              else {
              return
        }
        
        App.shared.getUserLogged { (info) in
            guard let u = info else {
                  return
            }
            
            let worlds = fieldName.text?.components(separatedBy: " ")
            
            var user:[String:Any] = [:]
            user["id_user"] = u.user_id
            user["nome"]    = worlds?.first
            user["sobrenome"]  = worlds?.last
            user["localidade"] = u.locality
            user["uf"]      = u.uf
            user["numero_telefone"] = fieldPhoneNumber.text
            user["email"]   = fieldEmailAccount.text
            user["pontos"]  = u.points
            
            App.shared.setUserLogged(information: user, { (save) in
                if save {
                   print("USUARIO ATUALIZADO COM SUCESSO")
                }
            })
        }
    }
    
    @IBAction func tapAbrirMenuPrincipal(_ sender: UIButton) {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
}

extension TelaSettingsViewController : UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate {
    
    @IBAction func uiChosePhotoUser(_ sender: UIButton) {
        let baseAlert = UIAlertController(title: "Carregar Foto", message: "Escolha uma das opções para carregar uma\n imagem ao perfil", preferredStyle: .actionSheet)
        
        let actionBaseAlertGalery = UIAlertAction(title: "Galeria", style: .default) { (_) in
            self.choseGalery()
        }
        
        let actionBaseAlertCamera = UIAlertAction(title: "Câmera", style: .default) { (g) in
            self.choseCamera()
        }
        
        let actionBaseAlertCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        baseAlert.addAction(actionBaseAlertGalery)
        baseAlert.addAction(actionBaseAlertCamera)
        baseAlert.addAction(actionBaseAlertCancel)
        self.present(baseAlert, animated: true, completion: nil)
    }
    
    func choseGalery() -> Void {
        let galeryPickerView = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.photoLibrary) {
            galeryPickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary
            galeryPickerView.allowsEditing = true
        }
        
        galeryPickerView.delegate   = self
        self.present(galeryPickerView, animated: true, completion: nil)
    }
    
    func choseCamera() -> Void {
        let cameraPickerView = UIImagePickerController()
    
        if UIImagePickerController.isSourceTypeAvailable(
           UIImagePickerControllerSourceType.camera) {
           cameraPickerView.sourceType = .camera
           cameraPickerView.delegate   = self
           cameraPickerView.allowsEditing = true
           cameraPickerView.cameraFlashMode = .auto
        }
        self.present(cameraPickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
         [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let originalImage = info[UIImagePickerControllerOriginalImage] as?   UIImage ?? (info[UIImagePickerControllerEditedImage] as? UIImage) else {
            return
        }
        
        self.uiUserPhoto?.contentMode = .scaleAspectFill
        self.uiUserPhoto?.setBackgroundImage(originalImage, for: .normal)
    }
}

extension TelaSettingsViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let photo = self.uiUserPhoto else {
            return
        }
        
        let photoWidth = photo.frame.size.width
        
        photo.center.x     = self.view.center.x
        photo.frame.size   = CGSize(width: 140.0, height: 140.0)
        photo.layer.cornerRadius = photoWidth * 0.5
        
        if scrollView.contentOffset.y < 1.0 {
           let photoWidthOriginal = photo.frame.size.width
           var yValueScroll = scrollView.contentOffset.y
        
           UIView.animate(withDuration: 0.4, animations: {
              photo.alpha = 1.0
           }, completion: { (_) in
              yValueScroll     = CGFloat(Int(yValueScroll) * -1)
              yValueScroll     = min(yValueScroll + photoWidthOriginal,280)
              photo.frame.size = CGSize(width: yValueScroll, height: yValueScroll)
              photo.center.x   = self.view.center.x
           })
        }else{
            UIView.animate(withDuration: 0.4, animations: {
               photo.alpha = 1.0
            }, completion: { (_) in
               photo.center.x   = self.view.center.x
               photo.frame.size = CGSize(width: 140.0, height: 140.0)
            })
        }
    }
}

