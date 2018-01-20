//
//  FacebookViewController.swift
//  FacebookImage
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var uiFacebookThumbImage: UIImageView?
    @IBOutlet weak var uiMessage: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let thumbImage = self.uiFacebookThumbImage,
              let message    = self.uiMessage else {
              return
        }
        
        thumbImage.isHidden = false
        message.isHidden    = true
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        searchBar.placeholder = "Digite um ID de usuário e toque em Search"
        searchBar.autocapitalizationType = .sentences
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }

    
    func recoveryImage(forId i:String?) -> Void {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let id = i else {
            return
        }
        
        let uri = "https://graph.facebook.com/\(id)/picture?type=large"
        guard let url = URL(string: uri) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let messageLabel = self.uiMessage,
                  let imageView    = self.uiFacebookThumbImage else {
                return
            }
            
            if let erro = error {
               let alertError = UIAlertController(title: "Erro no carregamento", message: erro.localizedDescription, preferredStyle: .alert)
               let actionAlertError = UIAlertAction(title: "Entendi", style: .default, handler: nil)
               alertError.addAction(actionAlertError)
               self.present(alertError, animated: true, completion: nil)
            }
            
            DispatchQueue.main.async {
                messageLabel.isHidden = true
                imageView.isHidden    = false
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            if let httpResponse = response as? HTTPURLResponse {
               print("COD: \(httpResponse.statusCode)")
               if httpResponse.statusCode == 404 {
                  DispatchQueue.main.async {
                    messageLabel.isHidden = false
                    imageView.isHidden    = true
                  }
               }
            }
            
            if let data = data {
               let imageThumb = UIImage(data: data)
               guard let imageView = self.uiFacebookThumbImage else {
                    return
               }

               DispatchQueue.main.async {
                    imageView.image = imageThumb
               }
            }
        }
        
        task.resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        searchBar.resignFirstResponder()
        self.recoveryImage(forId: text)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
