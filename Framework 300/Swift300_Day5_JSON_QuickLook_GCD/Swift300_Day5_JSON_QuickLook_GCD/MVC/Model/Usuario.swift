//
//  Usuario.swift
//  Swift300_Day5_JSON_QuickLook_GCD
//
//  Created by Swift on 02/12/2017.
//  Copyright © 2017 Nilo. All rights reserved.
//

/*
 {
    "account_id": "dbid:AACC2SaXGggA3EFSWpTAfnvWyZaMQbx6yiI",
    "name": {
        "given_name": "Dinho",
        "surname": "Lino",
        "familiar_name": "Dinho",
        "display_name": "Dinho Lino",
        "abbreviated_name": "DL"
    },
    "email": "dinho@tsubasa.com.br",
    "email_verified": true,
    "profile_photo_url": "https://dl-web.dropbox.com/account_photo/get/dbid%3AAACC2SaXGggA3EFSWpTAfnvWyZaMQbx6yiI?size=128x128&vers=1512058635375",
    "disabled": false,
    "country": "BR",
    "locale": "en",
    "referral_link": "https://db.tt/rHllhyaE3x",
    "is_paired": false,
    "account_type": {
        ".tag": "basic"
    },
    "root_info": {
        ".tag": "user",
        "root_namespace_id": "1876480656",
        "home_namespace_id": "1876480656"
    }
 }
 */

import Foundation

struct Usuario {
    
    let accountID:String
    let profilePicture:URL
    let name:String
    
    // JSON tem o formato [String:Any], ou seja
    // chave-valor, com chaves sempre String
    init?(data:[String:Any]){
       guard let idConta = data["account_id"] as? String else {
             return nil
       }
       self.accountID = idConta 
       
       guard let enderecoFoto = data["profile_photo_url"] as? String,
             let urlFoto = URL(string: enderecoFoto) else {
             return nil   
       }
       self.profilePicture = urlFoto
        
       guard let objNome = data["name"] as? [String:Any],
             let nome = objNome["display_name"] as? String else {
             return nil   
       }
       self.name = nome
    }
}
