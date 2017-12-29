//
//  TreeDetailsControllerView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 29/12/2017.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TreeDetailsControllerView : UIViewController {
    
    @IBOutlet weak var titleForTree:UILabel?
    @IBOutlet weak var imageForTree:WebImageView?
    
    var information:TreeTableViewCell?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let i = self.information,
              let title = self.titleForTree,
              let image = self.imageForTree else {
            return
        }
        
        title.text = i.treeTitle?.text
        image.image = i.treeImage?.image
    }
}
