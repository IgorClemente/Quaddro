//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uiFotoPerfil: UIImageView?
    @IBOutlet weak var uiPontuacao: UILabel?
    @IBOutlet weak var uiLocalidade: UILabel?
    @IBOutlet weak var uiNomeCompleto: UILabel?
    @IBOutlet weak var uiSpinnerSubMenu: UIActivityIndicatorView?
    @IBOutlet weak var viewFundoCinza: UIView?
    @IBOutlet weak var viewSubMenuArvores: UIView?
    @IBOutlet weak var viewSubMenuMapa: UIView?
    @IBOutlet var botoesSubMenu: [UIBarButtonItem]?
    
    var imagensArvores = [UIImage]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let remoteURL = URL(string:"https://inovatend.mybluemix.net/users/\(App.shared.userCpf)") else {
            return
        }
            
        var usuarioLogged:[String:Any] = [:]
           if let data = try? Data(contentsOf: remoteURL),
              let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()),
              let info = json as? [String:Any],
              let usuario = info["usuario"] as? [[String:Any]],
              let quantidadeArvores = info["arvores"] as? [String:Int],
              let ids_arvore        = info["arvore_ids"] as? [[String:Int]]  {
                 for u in usuario {
                    guard let nome = u["nome"] as? String,
                        let sobrenome = u["sobrenome"] as? String,
                        let id_user   = u["id_user"] as? Int,
                        let localidade = u["localidade"] as? String,
                        let uf    = u["uf"] as? String,
                        let numeroTelefone = u["numero_telefone"] as? String,
                        let email  = u["email"] as? String,
                        let pontos = u["pontos"] as? Int,
                        let quantidade = quantidadeArvores["quantidade"] else {
                                return
                    }
                    usuarioLogged["nome"]       = nome
                    usuarioLogged["sobrenome"]  = sobrenome
                    usuarioLogged["id_user"]    = id_user
                    usuarioLogged["localidade"] = localidade
                    usuarioLogged["uf"] = uf
                    usuarioLogged["numeroTelefone"] = numeroTelefone
                    usuarioLogged["email"]  = email
                    usuarioLogged["pontos"] = pontos
                    
                    App.shared.idTrees = ids_arvore
                    App.shared.amountOfTrees = quantidade
                 }
                 self.carregarInformacoesPerfil(usuarioLogged)
                 App.shared.setUserLogged(usuarioLogged)
              }
        
        let idArvores = App.shared.idTrees
        print("IDSSS\(idArvores)")
        for (idx,imagem) in idArvores.enumerated() {
            guard let id_arvore = imagem["arvore_id"], let remoteImageURL = URL(string:"https://inovatend.mybluemix.net/imagens/\(id_arvore)"),
                let remoteInfoURL = URL(string:"https://inovatend.mybluemix.net/imagens/arvore/\(id_arvore)") else {
                print("CAIU")
                return
            }
            Alamofire.request(remoteImageURL).responseData { (response) in
               if response.error == nil {
                  print(response.result)
                  if let data = response.data {
                     Alamofire.request(remoteInfoURL).responseData { (response) in
                        if response.error == nil{
                           if let info = response.data {
                              guard let json = try? JSONSerialization.jsonObject(with: info, options:  JSONSerialization.ReadingOptions()),
                                let info   = json as? [String:Any],
                                let arvore = info["arvore"] as? [String:Any] else {
                                return
                              }
                              self.createMenuArvores(arvoreImagem:UIImage(data: data) ?? UIImage(),arvoreId:idx,arvore)
                              self.uiSpinnerSubMenu?.stopAnimating()
                                    
                           }
                        }
                     }
                  }
                }
            }
        }
        
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
    
    func carregarInformacoesPerfil(_ u:[String:Any]) {
        guard let nomeCompleto = (((u["nome"] as? String) ?? "") + " " + ((u["sobrenome"] as? String) ?? "")) as? String,
              let localidade   = (((u["localidade"] as? String) ?? "") + "," + ((u["uf"] as? String) ?? "")) as? String,
              let pontos       = u["pontos"] as? Int
            else {
            return
        }
        self.uiNomeCompleto?.text = nomeCompleto
        self.uiLocalidade?.text   = localidade
        self.uiPontuacao?.text    = "\(pontos)"
    }
    
    func uploadImagemServer() {
        let parameters = ["user":"Sol", "password":"secret1234"]
        // Image to upload:
        let imageToUploadURL = Bundle.main.url(forResource: "tree", withExtension: "png")
        // Server address (replace this with the address of your own server):
        let url = "https://inovatend.mybluemix.net/imagens/arvore/salvar"
        // Use Alamofire to upload the image
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                multipartFormData.append(imageToUploadURL!, withName: "image")
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let jsonResponse = response.result.value as? [String: Any] {
                            print(jsonResponse)
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    
    
    func createMenuArvores(arvoreImagem:UIImage, arvoreId:Int,_ arvoreInfo:[String:Any]) {
        guard let fundoCinza = self.viewFundoCinza,
              let titulo = arvoreInfo["titulo"] as? String,
              let pontos = arvoreInfo["pontos"] as? Int  else {
            return
        }
        
        var limitadoresRegras = [NSLayoutConstraint]()
        let comprimentoArvore = self.view.frame.size.width
        
        let arvoreItem   = UIView()
        arvoreItem.frame = CGRect(x:0,y:CGFloat(arvoreId*101),width:comprimentoArvore,height:100)
        arvoreItem.backgroundColor = UIColor(white:1,alpha:0.9)
            
        let  fotoArvore   = UIImageView()
        fotoArvore.frame  = CGRect(x:0,y:0,width:50,height:50)
        fotoArvore.image  = arvoreImagem
        fotoArvore.contentMode = .scaleAspectFill
        fotoArvore.layer.cornerRadius = fotoArvore.frame.width/2
        fotoArvore.clipsToBounds = true
        fotoArvore.translatesAutoresizingMaskIntoConstraints = false
          
        let tituloArvore   = UILabel()
        tituloArvore.frame = CGRect(x:90,y:23,width:200,height:30)
        tituloArvore.font  = UIFont.systemFont(ofSize: 18)
        tituloArvore.textColor = UIColor.black
        tituloArvore.text = titulo
            
        let regiaoArvore   = UILabel()
        regiaoArvore.frame = CGRect(x:90,y:45,width:100,height:30)
        regiaoArvore.font  = UIFont.preferredFont(forTextStyle: UIFontTextStyle("light"))
        regiaoArvore.font  = UIFont.systemFont(ofSize: 15)
        regiaoArvore.textColor = UIColor.gray
        regiaoArvore.text = "Guarulhos, SP"
            
        let pontuacaoArvore   = UILabel()
        pontuacaoArvore.frame = CGRect(x:0,y:0,width:100,height:30)
        pontuacaoArvore.font  = UIFont.preferredFont(forTextStyle: UIFontTextStyle("light"))
        pontuacaoArvore.font  = UIFont.systemFont(ofSize: 17)
        pontuacaoArvore.textColor = UIColor.darkGray
        pontuacaoArvore.text  = "\(pontos) pontos"
        pontuacaoArvore.translatesAutoresizingMaskIntoConstraints = false
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.leading, relatedBy:.equal, toItem:arvoreItem, attribute:.leading, multiplier:1.0, constant:15)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.centerY, relatedBy:.equal, toItem:arvoreItem, attribute:.centerY, multiplier:1.0, constant:0)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.width, relatedBy:.equal, toItem:nil, attribute: .notAnAttribute, multiplier:1.0, constant:50)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:fotoArvore, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1.0, constant:50)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:pontuacaoArvore, attribute:.trailing, relatedBy:.equal, toItem:fundoCinza, attribute:.trailing, multiplier:1.0, constant:0)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:pontuacaoArvore, attribute:.centerY, relatedBy:.equal, toItem:arvoreItem, attribute:.centerY, multiplier:1.0, constant:0)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:pontuacaoArvore, attribute:.height, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1.0, constant:30)])
            
            limitadoresRegras.append(contentsOf:[NSLayoutConstraint(item:pontuacaoArvore, attribute:.width, relatedBy:.equal, toItem:nil, attribute:.notAnAttribute, multiplier:1.0, constant:100)])
            
            arvoreItem.addSubview(pontuacaoArvore)
            arvoreItem.addSubview(tituloArvore)
            arvoreItem.addSubview(regiaoArvore)
            arvoreItem.addSubview(fotoArvore)
            fundoCinza.addSubview(arvoreItem)
        
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
            let alerta = UIAlertController(title:"Imagem", message:"Imagem Salva com Sucesso !", preferredStyle: .alert)
            let confirmaAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alerta.addAction(confirmaAction)
            self.present(alerta, animated: true, completion: nil)
        }
    }
}

