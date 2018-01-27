//
//  VeiculoDetailTableViewCell.swift
//  WebServiceTabelaFipe
//
//  Created by MACBOOK AIR on 22/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class VeiculoDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var title:UILabel?
    @IBOutlet weak var yearModel:UILabel?
    @IBOutlet weak var price:UILabel?
    @IBOutlet weak var fuel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
