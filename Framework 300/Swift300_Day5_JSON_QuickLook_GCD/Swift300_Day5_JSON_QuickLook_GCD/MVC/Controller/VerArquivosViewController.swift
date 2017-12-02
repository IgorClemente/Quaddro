//
//  VerArquivosViewController.swift
//  Swift300_Day5_JSON_QuickLook_GCD
//
//  Created by Swift on 02/12/2017.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit
import QuickLook

class VerArquivosViewController: QLPreviewController,
      QLPreviewControllerDataSource {
    
    var conteudo:Conteudo? = nil
    var caminhoLocal:NSURL? = nil
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return caminhoLocal != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return caminhoLocal ?? NSURL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let conteudo = conteudo else{
            return
        }
        
        let endpoint = "https://content.dropboxapi.com/2/files/download"
        let data = Derpbox.compartilhado.dados(vindoDe: endpoint, headers: ["path": conteudo.caminho])
        
        // Depois de baixar precisamos salvar em algum lugar!
        // past temp -> cachesDirectory
        // userDomainMask -> pastas que eu posso ler e escrever
        let pastaTemp = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        print(pastaTemp)
        // Agora juntamos o caminho absoluto da pasta (ex: /var/apps/23456789/derpbox/caches/)
        // com o nome do arquivo
        
        let pastaComArquivo = "\(pastaTemp)/\(conteudo.nome)"
        let caminhoComURL   = URL(fileURLWithPath: pastaComArquivo)
        
        do{
            try data?.write(to: caminhoComURL)
            self.caminhoLocal = NSURL(fileURLWithPath: pastaComArquivo)
            self.dataSource = self
            self.reloadData()
        }catch{
            print("Ops! erro na escrita em disco")
        }
    }
}
