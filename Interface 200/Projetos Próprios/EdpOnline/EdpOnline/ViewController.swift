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
    
    @IBOutlet weak var uiProfilePhoto: UIImageView?
    @IBOutlet weak var uiPoints: UILabel?
    @IBOutlet weak var uiLocality: UILabel?
    @IBOutlet weak var uiFullName: UILabel?
    @IBOutlet weak var tableSubMenuArvores: UITableView?
    @IBOutlet weak var uiSubMenuMap: UIView?
    @IBOutlet var uiButtonsSubMenu: [UIBarButtonItem]?
    @IBOutlet weak var uiProgressBarUpload: UIProgressView?
    @IBOutlet weak var uiMapRegionMain: MKMapView?
    
    @IBOutlet var uiStarsBarBottom: [UIImageView]?
    
    // MARK: images trees
    var imagensArvores = [UIImage]()
    
    // MARK: managerLocation - geocoder
    let locationManagerUser = CLLocationManager()
    let geocoder            = CLGeocoder()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let urlUser = "https://inovatend.mybluemix.net/users/\(App.shared.userCpf)"
        guard let remoteURL = URL(string: urlUser),
              let progress  = self.uiProgressBarUpload   else {
              return
        }
        // Barra de Progresso - UploadImagem
        progress.setProgress(0.0, animated: true)
        progress.isHidden = true
        
        //MARK : Stars Bottom Bar
        if let stars = self.uiStarsBarBottom {
           for s in 0..<stars.count {
             let star = stars[s]
             if (0..<App.shared.amountOfStars).contains(s) {
                star.image = UIImage(named:"star")
             }else{
                star.image = UIImage(named:"star-disabled")
             }
           }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("update-map"),
                                               object: nil, queue: OperationQueue.main) { _ in
            self.saveUserInfo(remoteURL)
            self.searchLocation()
            self.tableSubMenuArvores?.reloadData()
        }
        
        self.saveUserInfo(remoteURL)
        self.searchLocation()
        self.tableSubMenuArvores?.reloadData()
    }
    
    func saveUserInfo(_ remoteURL:URL) -> Void {
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
           self.loadInformation(forUser: usuarioLogged)
           App.shared.setUserLogged(usuarioLogged)
           App.shared.saveInformationTrees()
        }
    }
    
    func loadInformation(forUser u:[String:Any]) -> Void {
        guard let firstName  = u["nome"] as? String ,
              let lastName   = u["sobrenome"] as? String ,
              let locality   = u["localidade"] as? String ,
              let uf         = u["uf"] as? String ,
              let points     = u["pontos"] as? Int
              else {
              return
        }
        self.uiFullName?.text = "\(firstName) \(lastName)"
        self.uiLocality?.text   = "\(locality),\(uf)"
        self.uiPoints?.text    = "\(points)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let buttons = uiButtonsSubMenu,
              let treesTable = tableSubMenuArvores,
              let treesMap = uiSubMenuMap else {
              return
        }
        
        for button in buttons {
            guard let titleButton = button.title else {
                return
            }
            
            if titleButton == "submenuMapa" {
               button.tintColor = UIColor.gray
               treesTable.isHidden = false
               treesMap.isHidden = true
            }
        }
    }
    
    @IBAction func uiTapAbreMenuPrincipal() {
        ControllerLateralMenu.controller.criarMenuPrincipal(self)
    }
    
    @IBAction func tapSubMenu(_ sender: UIBarButtonItem) {
        guard let botoes  = uiButtonsSubMenu,
              let viewSubMapa = uiSubMenuMap,
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
                }else{
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
    
    func tirarFoto() -> Void {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        DispatchQueue.global().async {
           if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
              let imagemData = UIImagePNGRepresentation(imagePicked)
              let imagemComprimida = UIImage(data: imagemData ?? Data())
              self.enviarFotoServidor(imagePicked)
              DispatchQueue.main.async {
                 picker.dismiss(animated: true, completion: nil)
                 UIImageWriteToSavedPhotosAlbum(imagemComprimida ?? UIImage() , nil, nil, nil)
            
                 let sucessAlert = UIAlertController(title:"Imagem", message:"Imagem salva com sucesso !", preferredStyle: .alert)
                 let confirmSucessAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                 sucessAlert.addAction(confirmSucessAlert)
                 self.present(sucessAlert, animated: true, completion: nil)
              }
           }
        }
    }
    
    func enviarFotoServidor(_ image:UIImage) {
        guard let remote = URL(string:"https://inovatend.mybluemix.net/upload"),
              let imageData   = UIImagePNGRepresentation(image),
              let progressBar = self.uiProgressBarUpload
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
                    
                    // MARK: Notification End Progress - BackgroundMode
                    DispatchQueue.main.async {
                       if UIApplication.shared.applicationState == .background {
                          let contentNotification   = UNMutableNotificationContent()
                          contentNotification.body  = "Imagem enviada com sucesso"
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
        if let locationUser = App.shared.currentLocation {
           let pinUser  = TreeAnnotation(forLocation: locationUser)
           self.uiMapRegionMain?.addAnnotation(pinUser)
        }
        
        if let trees = App.shared.retrieveInformationTrees() {
           trees.forEach({ (tree) in
              if let locationTree = tree.location {
                 let pinTree = TreeAnnotation(forLocation: locationTree)
                 self.uiMapRegionMain?.addAnnotation(pinTree)
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
        let treesIdentifiers = App.shared.treesIndentifiers
        
        guard let cellTree = tableView.dequeueReusableCell(withIdentifier: "tree") as? TreeTableViewCell,
              let identifiers = treesIdentifiers else {
            return UITableViewCell()
        }
        
        let identifier  = identifiers[indexPath.row]
        if let tree = identifier["arvore_id"] {
            
           let cellInfoURL  = "https://inovatend.mybluemix.net/imagens/arvore/\(tree)"
           let cellImageURL = "https://inovatend.mybluemix.net/imagens/\(tree)"
           
           cellTree.useCell = true
           cellTree.treeImage?.url = URL(string:cellImageURL)
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
