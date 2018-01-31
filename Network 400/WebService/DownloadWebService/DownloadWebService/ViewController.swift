//
//  ViewController.swift
//  DownloadWebService
//
//  Created by Swift on 27/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import AVKit


/*
 
 https://d1235ca2z646oc.cloudfront.net/videos/processed/1716/Northernlights2_HD.mp4.mp4
 
 */

class ViewController: UIViewController {

    @IBOutlet weak var uiBarProgress:UIProgressView?
    
    // Sessão do carregamento
    var sessao:URLSession?
    
    // Tarefa do Download
    var task:URLSessionDownloadTask?
    
    // Variável para controlar quando estamos fazendo o Download
    var isDownload = false
    
    // Para guardar os dados do carregamento
    var buffer:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiBarProgress?.progress = 0
        // Criar uma sessao e ligar o delegate
        self.sessao = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }

    @IBAction func tapDownloadButton(_ sender: UIButton) {
        // Garantir que possuímos a URL do vídeo
        guard let url = URL(string: "https://d1235ca2z646oc.cloudfront.net/videos/processed/1716/Northernlights2_HD.mp4.mp4") else {
            return
        }

        // Criar a tarefa de carregamento
        self.task = sessao?.downloadTask(with: url)
        
        // Zerar o progress
        self.uiBarProgress?.progress = 0
        self.isDownload = true
        
        // Iniciar a tarefa
        self.task?.resume()
    }
    
    @IBAction func tapPlayPauseButton(_ sender: UIButton) {
        // Verificar se o download está em andamento
        if self.isDownload {
           // Pausar
           self.isDownload = false
           // Cancelar a tarefa de Download e guardar os dados já baixados
           self.task?.cancel(byProducingResumeData: { (dados) in
               self.buffer = dados
           })
        } else {
           // Continuar
           guard let buffer = self.buffer else {
               return
           }
           self.isDownload = true
           // Criar uma nova tarefa apartir dos dados baixados
           self.task = self.sessao?.downloadTask(withResumeData: buffer)
           self.task?.resume()
        }
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.task?.cancel()
        self.isDownload = false
        self.uiBarProgress?.progress = 0
        
        // Limpar o buffer
        self.buffer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: URLSessionDownloadDelegate {
    
    // Função que retorna o progresso de uma download
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // Acessar a main, para alterar a interface
        DispatchQueue.main.async {
            // Atualizar o progress
            self.uiBarProgress?.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        }
    }
    
    // Função que retorna quando um Download é concluido
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            // Limpar o buffer
            self.buffer = nil
            
            // O arquivo é salvo em uma pasta temporária.
            // Vamos acessar o diretório de Documentos
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            // Criar uma URL para salvar o arquivo
            let videoURL = documentsURL.appendingPathComponent(location.lastPathComponent.appending(".mp4"))
            
            // Mover o arquivo baixado da pasta temporária para a pasta de documentos
            try FileManager.default.moveItem(at: location, to: videoURL)
            
            // Criar um player
            let player = AVPlayer(url: videoURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
        
            DispatchQueue.main.async {
                self.present(playerController, animated: true, completion: {
                    player.play()
                })
            }
        } catch {
            print("Falha ao abrir: ",error)
        }
    }
}

