//
//  MeViewController.swift
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var uiName:UILabel?
    @IBOutlet weak var uiProfilePic:WebImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        Derpbox.compartilhado.sobreEU { (usuario) in
            self.uiName?.text = usuario?.name
            self.uiProfilePic?.url = usuario?.profilePicture
        }
    }
}
