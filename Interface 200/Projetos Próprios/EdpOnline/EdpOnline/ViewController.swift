//
//  ViewController.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 22/09/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import UserNotifications

class ViewController: UIViewController,UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {
    
    @IBOutlet weak var uiFotoPerfil: UIImageView?
    @IBOutlet weak var uiPontuacao: UILabel?
    @IBOutlet weak var uiLocalidade: UILabel?
    @IBOutlet weak var uiNomeCompleto: UILabel?
    @IBOutlet weak var uiSpinnerSubMenu: UIActivityIndicatorView?
    @IBOutlet weak var viewFundoCinza: UIView?
    @IBOutlet weak var tableSubMenuArvores: UITableView?
    @IBOutlet weak var viewSubMenuMapa: UIView?
    @IBOutlet var botoesSubMenu: [UIBarButtonItem]?
    @IBOutlet weak var uiProgressUpload: UIProgressView?
    
    
    @IBOutlet weak var uiMapRegionMain: MKMapView?
    
    // MARK: Imagens Arvores
    var imagensArvores = [UIImage]()
    
    // MARK: Gestor de Localização
    let locationManagerUser = CLLocationManager()
    let geocoder            = CLGeocoder()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.searchLocation()
        super.viewWillAppear(true)
        
        let urlUser = "https://inovatend.mybluemix.net/users/\(App.shared.userCpf)"
        guard let remoteURL = URL(string: urlUser),
              let progress  = self.uiProgressUpload   else {
              return
        }
        // Barra de Progresso - UploadImagem
        progress.setProgress(0.0, animated: true)
        progress.isHidden = true
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("update-map"),
                                               object: nil, queue: OperationQueue.main)
            { _ in
            self.saveUserInfo(remoteURL)
            self.searchLocation()
            self.tableSubMenuArvores?.reloadData()
        }
        self.saveUserInfo(remoteURL)
        self.tableSubMenuArvores?.reloadData()
    }
    
    
    func saveUserInfo(_ remoteURL:URL) {
        
        var usuarioLogged:[String:Any] = [:]
        
        if let data = try? Data(contentsOf: remoteURL),
           let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()),
           let info    = json as? [String:Any],
           let usuario = info["usuario"] as? [[String:Any]],
           let quantidadeArvores = info["arvores"] as? [String:Int],
           let ids_arvore        = info["arvore_ids"] as? [[String:Int]]  {
            
           for u in usuario {
              guard let nome = u["nome"] as? String,
                    let sobrenome  = u["sobrenome"] as? String,
                    let id_user    = u["id_user"] as? Int,
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
                
                App.shared.treesIndentifiers = ids_arvore
                App.shared.amountOfTrees = quantidade
           }
            
           self.carregarInformacoesPerfil(usuarioLogged)
           App.shared.setUserLogged(usuarioLogged)
           App.shared.saveInformationTrees()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let botoes = botoesSubMenu,
            let subArvores = tableSubMenuArvores,
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
              let viewSubArvore = tableSubMenuArvores else {
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
                 }else{
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
        guard let nome         = u["nome"] as? String ,
              let sobrenome    = u["sobrenome"] as? String ,
              let localidade   = u["localidade"] as? String ,
              let uf           = u["uf"] as? String ,
              let pontos       = u["pontos"] as? Int
            else {
            return
        }
        self.uiNomeCompleto?.text = "\(nome) \(sobrenome)"
        self.uiLocalidade?.text   = "\(localidade),\(uf)"
        self.uiPontuacao?.text    = "\(pontos)"
    }
    
    func tirarFoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
           let imagemData = UIImagePNGRepresentation(imagePicked)
           let imagemComprimida = UIImage(data: imagemData ?? Data())
           picker.dismiss(animated: true, completion: nil)
            
           enviarFotoServidor(imagePicked)
           UIImageWriteToSavedPhotosAlbum(imagemComprimida ?? UIImage() , nil, nil, nil)
            
           let alerta = UIAlertController(title:"Imagem", message:"Imagem salva com Sucesso !", preferredStyle: .alert)
           let confirmaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alerta.addAction(confirmaAction)
           self.present(alerta, animated: true, completion: nil)
        }
    }
    
    func enviarFotoServidor(_ image:UIImage) {
        guard let remote = URL(string:"https://inovatend.mybluemix.net/upload"),
              let imageData   = UIImagePNGRepresentation(image),
              let progressBar = self.uiProgressUpload
              else {
              return
        }
        
        let currentLocation = App.shared.currentLocation
        
        guard let longitude = currentLocation?.longitude.description,
              let latitude  = currentLocation?.latitude.description,
              let longitudeData = longitude.data(using: String.Encoding.utf8),
              let latitudeData  = latitude.data(using: String.Encoding.utf8) else {
              return
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "sampleFile",fileName: "sampleFile.png", mimeType: "image/png")
            multipartFormData.append(longitudeData, withName: "longitude")
            multipartFormData.append(latitudeData, withName: "latitude")
        },
        to: remote)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    progressBar.isHidden = false
                    print("Upload Progress: \(progress.fractionCompleted)")
                    progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
                })
                upload.responseJSON { response in
                    progressBar.isHidden = true
                    progressBar.setProgress(0.0, animated: false)
                    print("RESULTADO => =>",response.result.value)
                    
                    // MARK: Notification End Progress
                    DispatchQueue.main.async {
                        if UIApplication.shared.applicationState == .background {
                            let contentNotification   = UNMutableNotificationContent()
                            contentNotification.body  = "Imagem enviada com Sucesso"
                            contentNotification.title = "Envio de Imagem"
                            
                            let notificationProgress = UNNotificationRequest(identifier: "upload", content: contentNotification, trigger: nil)
                            UNUserNotificationCenter.current().add(notificationProgress, withCompletionHandler: nil)
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name("update-map") , object: nil)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}


extension ViewController : CLLocationManagerDelegate {
    
    func preparePinsUpdate() -> Void {
        self.uiMapRegionMain?.removeAnnotations(uiMapRegionMain?.annotations ?? [])
        if let location = App.shared.currentLocation {
           let pinTree  = TreeAnnotation(forLocation: location)
           self.uiMapRegionMain?.addAnnotation(pinTree)
        }
        
        if let ts = App.shared.retrieveInformationTrees() {
           ts.forEach({ (tree) in
              if let location = tree.location {
                 let pin = TreeAnnotation(forLocation: location)
                 self.uiMapRegionMain?.addAnnotation(pin)
              }
           })
        }
    }
    
    func updateMap(infoPlaceMark info:CLPlacemark) -> Void {
        guard let location = info.location else {
            return
        }
        let regionSize = MKCoordinateSpanMake(0.01,0.01)
        let region     = MKCoordinateRegionMake(location.coordinate, regionSize)
        
        self.preparePinsUpdate()
        self.uiMapRegionMain?.setRegion(region, animated: true)
    }
    
    func searchLocation() {
        switch CLLocationManager.authorizationStatus() {
          case .authorizedAlways, .authorizedWhenInUse:
            locationManagerUser.delegate        = self
            locationManagerUser.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManagerUser.startUpdatingLocation()
          case .notDetermined:
            requestLocationPermission()
          default:
            break
        }
    }
    
    func requestLocationPermission() -> Void {
        if CLLocationManager.locationServicesEnabled() {
            locationManagerUser.delegate = self
            locationManagerUser.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        
        locationManagerUser.stopUpdatingLocation()
        geocoder.reverseGeocodeLocation(lastLocation) {
            (locations, error) in
            if let locationFirst = locations?.first,
               let location = locationFirst.location {
               App.shared.currentLocation = location.coordinate
               self.updateMap(infoPlaceMark: locationFirst)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
          case .authorizedAlways, .authorizedWhenInUse:
            self.searchLocation()
          default:
            break
        }
    }
}

extension ViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let location = annotation as? TreeAnnotation {
           return self.uiMapRegionMain?.dequeueReusableAnnotationView(withIdentifier: location.identifier) ?? location.viewTreeAnnotation()
        }else{
            return nil
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.shared.amountOfTrees
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellTree = tableView.dequeueReusableCell(withIdentifier: "tree") as? TreeTableViewCell else {
            return UITableViewCell()
        }
        
        let treesIdentifiers = App.shared.treesIndentifiers
        
        if let identifiers = treesIdentifiers,
           let identifier  = identifiers[indexPath.row] as? [String:Int],
           let tree        = identifier["arvore_id"] {
           
           let cellInfoURL  = "https://inovatend.mybluemix.net/imagens/arvore/\(tree)"
           let cellImageURL = "https://inovatend.mybluemix.net/imagens/\(tree)"
            
           cellTree.treeImage?.url  = URL(string:cellImageURL)
           cellTree.url            = URL(string:cellInfoURL)
        }
        return cellTree
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
