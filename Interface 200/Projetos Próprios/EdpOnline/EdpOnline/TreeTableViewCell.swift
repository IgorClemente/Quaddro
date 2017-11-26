//
//  TreeTableViewCell.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 20/11/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit
import Alamofire

class TreeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var treeTitle:UILabel?
    @IBOutlet weak var treeLocation:UILabel?
    @IBOutlet weak var treePoints:UILabel?
    @IBOutlet weak var treeImage:WebImageView?
    
    var url:URL? {
        didSet{
          guard let remoteURL = url else{
             return
          }
          Alamofire.request(remoteURL).responseData(completionHandler: {
            (response) in
            if response.error == nil,
               let data = response.data {
               guard let json = try? JSONSerialization.jsonObject(
                       with: data, options: JSONSerialization.ReadingOptions()),
                     let info     = json as? [String:Any],
                     let treeInfo = info["arvore"] as? [String:Any],
                     let title    = treeInfo["titulo"] as? String,
                     let points   = treeInfo["pontos"] as? Int
                     else {
                          return
               }
               self.treeTitle?.text  = title
               self.treePoints?.text = "\(points) Pontos"
            }
          })
        }
    }
}
