//
//  Objetivo.swift
//  RealmObjetivos
//
//  Created by Swift on 03/02/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import RealmSwift

class Objetivo: Object {
    
    @objc dynamic var nome: String?
    let concluido = RealmOptional<Bool>()
}
