//
//  TreeDetailsControllerView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 29/12/2017.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TreeDetailsControllerView : UIViewController {
    
    private var infos:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let i = self.infos else {
            return
        }
        
        print("AQUI",i)
    }
}
