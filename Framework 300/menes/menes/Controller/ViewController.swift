//
//  ViewController.swift
//  menes
//
//  Created by Swift on 16/12/2017.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit
import SafariServices
import AVKit

class ViewController: UIViewController, UITableViewDelegate,
                      UITableViewDataSource {

    @IBOutlet weak var uiTableVideos:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTableVideos?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosMenes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celulaVideo = tableView.dequeueReusableCell(withIdentifier: "video") as? TableViewCellVideo
              else {
              return  UITableViewCell()
        }
        
        let menes = todosMenes()
        celulaVideo.tituloVideo?.text  = menes[indexPath.row].name
        celulaVideo.duracaoVideo?.text = "\(menes[indexPath.row].length/60)m\(menes[indexPath.row].length%60)s"
        celulaVideo.thumbImage?.url    = menes[indexPath.row].thumb

        return celulaVideo
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Eu vou para webview ou para player nativo?
        let memes = todosMenes()
        let mene  = memes[indexPath.row]
        
        if mene.html {
           // Vai para o safari
           let safari = SFSafariViewController(url: mene.url)
           self.present(safari, animated: true, completion: nil) 
        }else{
           // Vai para o Safari
           let tocador = AVPlayer(url: mene.url)
           let tela    = AVPlayerViewController()
           tela.player = tocador
           present(tela, animated: true) {
               tocador.play()
           } 
        }
    }
}
