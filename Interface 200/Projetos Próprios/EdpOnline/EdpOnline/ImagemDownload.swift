//
//  ControllerImagensDownload.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 15/10/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit
import Alamofire

class ImagemDownload {

func getImagensArvores() -> [UIImage]? {
    var imagensArvores = [UIImage]()
    for imagem in 1...10 {
        guard let remoteImageURL = URL(string:"https://inovatend.mybluemix.net/imagens/\(imagem)") else {
         return nil
        }
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                    print(response.result)
                if let data = response.data {
                    imagensArvores.append(UIImage(data: data) ?? UIImage())
                }
            }
        }
    }
    return imagensArvores
}
}
