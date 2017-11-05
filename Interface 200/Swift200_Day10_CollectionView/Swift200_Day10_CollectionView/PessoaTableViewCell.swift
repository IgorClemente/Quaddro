//
//  PessoaTableViewCell.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class PessoaTableViewCell: UITableViewCell {

    @IBOutlet weak var uiNome:UILabel?
    @IBOutlet weak var uiFotinho:WebImageView?
    
    @IBOutlet var uiRostinhos:[RostinhoButton]?
    
    var pessoa:Person? {
        didSet {
            uiRostinhos?.forEach {
                $0.pessoa = pessoa
            }
        }
    }
}
