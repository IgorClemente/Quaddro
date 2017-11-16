//
//  CameraViewController.swift
//  Swift300_Day2_CoreImage
//

import UIKit
import CoreImage

class CameraViewController : UIViewController, CIFilterPickerDelegate, AdjustsViewDelegate, UINavigationControllerDelegate {
        
    // Outlets de interface
    @IBOutlet weak var uiThumb: UIImageView?
    @IBOutlet weak var uiFilterPicker: CIFilterPicker?
    @IBOutlet weak var uiAdjusts:AdjustsView?
    @IBOutlet weak var uiSpinner:UIActivityIndicatorView?
    
    
    override var prefersStatusBarHidden: Bool { return true }
    var imagemOriginal:UIImage?
    
    // Delegate de CIFilterPickerDelegate & AdjustsViewDelegate
    func filterChanged() {      tratarImagem() }
    func adjustsDidChange() {   tratarImagem() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiFilterPicker?.filterDelegate = self
    }
    
    
    @IBAction func tapPick() {
        
        // TODO-1) Mostrar o picker em modo câmera
        
        // Essa tela vai mostrar a camera e tirar uma foto pra gente
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType         = .camera
            picker.cameraCaptureMode  = .photo
            picker.cameraFlashMode    = .off
            // Permite que o usuário escolha o foco da imagem
            // antes de passar pra gente
            picker.allowsEditing      =  true
        } else {
            print("Ops ! camera indisponível")
            return
        }
        
        
        picker.delegate = self                                  // Isso configura esta tela para receber a imagem
        self.present(picker, animated: true, completion: nil)   // Apresentando a tela como qualquer outra
    }
    
    @IBAction func tapChoose() {
        
        // TODO-2) Mostrar o picker em modo álbum
        
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
           picker.sourceType     = .photoLibrary
           picker.allowsEditing  = true 
        } else {
            print("Erro ao abrir galeria")
            return
        }
        
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func tratarImagem(){
        
        
        // TODO-7) Spinner e GCD
        // Trocamos para CPU auxiliar
        
        DispatchQueue.global().async {
        
            DispatchQueue.global().async {
                self.uiSpinner?.startAnimating()
            }
         
            // TODO-3) Aplicar o efeito de ruído com multiply
            var filtroEscolhido = ""
        
            // Primeira coisa é converter o formatado imagem para que o core image entenda
            guard var imagemEscolhida = self.imagemOriginal else {
                return 
            }
        
            // TODO-6) pesado? thumb da imagem
            let largura = imagemEscolhida.size.width/6
            let altura  = imagemEscolhida.size.height/6
            imagemEscolhida = imagemEscolhida.copyImage(croppingTo: CGSize(width: largura, height: altura))
        
            // TODO-5.2) Mudar HUE
            imagemEscolhida = imagemEscolhida.changeBits { (linha, coluna, pixel) -> (Pixel) in
            
                let h = self.uiAdjusts?.hue ?? 0
                let s = self.uiAdjusts?.saturation ?? 0
                let novoPixel = pixel.change(hue: h, saturation: s)
                return novoPixel
                
            }
        
            guard var escolhida = CIImage(image: imagemEscolhida) else {
                return
            }
        
            // TODO-4) Aplicar outros filtros (bloom, comic, etc)
       
            switch self.uiFilterPicker?.selectedFilter ?? .none {
           
                case .none:
                    DispatchQueue.main.sync {
                        self.uiThumb?.image = imagemEscolhida
                        self.uiSpinner?.stopAnimating()
                    }
                    return
                break
            
                default:
                    guard let filtro = self.uiFilterPicker?.selectedFilter.rawValue else {
                        return
                    }
                    filtroEscolhido = filtro
                
                    let filter = CIFilter(name: filtroEscolhido)
                    filter?.setValue(escolhida, forKey: "inputImage")
                    escolhida = filter?.outputImage ?? escolhida
                    print("FILTRO ESCOLHIDO ->",filtroEscolhido)
            }
        
        
        
            // Image 2) ruído, redimensionado para o tamanho da imagem da camera
            guard let imagemRuido = UIImage(named: "noise")?.copyImage(croppingTo: imagemEscolhida.size),
                  let ruido       = CIImage(image: imagemRuido) else {
                    return
            }
        
        // Fazendo o filtro de multiply
        // |    - nome -   |
        // | chave / valor |
        // |     output    |
        // que junta as duas imagens
        
        guard let misturador = CIFilter(name: "CIMultiplyCompositing") else {
            return
        }
        
        // Configurando as imagens do filtro
        misturador.setValue(escolhida, forKey: "inputBackgroundImage")
        misturador.setValue(ruido, forKey: "inputImage")
        
        // Recupera a imagem tratada
        guard let resultado = misturador.outputImage else {
            return
        }
        
        // Aplicar na tvzinha, mas precisa converter
        guard let cg = CIContext(options: nil).createCGImage(resultado, from: resultado.extent) else {
            return
        }
        //Preciso voltar para CPU principal
            DispatchQueue.main.sync {
                self.uiThumb?.image = UIImage(cgImage: cg)
                self.uiSpinner?.stopAnimating()
            }
        }    
        
    }
    
    @IBAction func tapShare(){
        // TODO-8) share da imagem editada
        
        // Pegamos a imagem que está sendo apresentada
        guard let imagem = self.uiThumb?.image else {
            return
        }
        
        // Cria uma tela de share com o conteúdo interesse
        // O que tem nesse vetor decide o aplicativo
        let share = UIActivityViewController(activityItems: [imagem, "-NOSSA-"], applicationActivities: nil)
        self.present(share, animated: true, completion: nil)
    }

}

extension CameraViewController : UIImagePickerControllerDelegate {

    // A) Deu certo, ele escolheu
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Escolheu")
        
        // Aqui precisamos pedir para a tela sair 
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage ?? 
                         (info[UIImagePickerControllerOriginalImage] as? UIImage) else {
            print("Kade a imagem ?")
            return
        }
        imagemOriginal = image
        tratarImagem()
    }
    
    // B) O cara, desistiu
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("Desistiu")
    }

}
