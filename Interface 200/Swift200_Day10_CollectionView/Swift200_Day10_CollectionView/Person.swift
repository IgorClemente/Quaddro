//
//  Person.swift
//  Pessoas
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import Foundation

enum Is : String {
    case happy, ok, unhappy, sad
}

enum Kind : String {
    case family, work, friends
}

class Person : NSObject, NSCoding {
    
    let name:String
    let pic:URL
    let kind:Kind
    let contact:URL
    var `is`:Is {
        didSet{ save() }
    }
    
    static func make(with data:FinderSelectedUser) -> Person {
        
        let kind:Kind
        
        switch data.category{
        case .family: kind = .family
        case .work: kind = .work
        case .friends: kind = .friends
        }
        
        return Person(name: data.name, pic: data.pic,
                      kind: kind, contact: data.contact)
    }
    
    required convenience init?(coder d: NSCoder){
        
        guard let name    = d.decodeObject(forKey: "name") as? String,
              let pic     = d.decodeObject(forKey: "pic") as? URL,
              let contact = d.decodeObject(forKey: "contact") as? URL,
              let kindStr = d.decodeObject(forKey: "kind") as? String,
              let kind    = Kind(rawValue:kindStr),
              let isStr   = d.decodeObject(forKey: "is") as? String,
              let `is`    = Is(rawValue:isStr)else{
                return nil
        }
        
        self.init(name: name, pic: pic, kind: kind, contact: contact, is:`is`)
    }
    
    func encode(with c: NSCoder){
        c.encode(name, forKey: "name")
        c.encode(pic, forKey: "pic")
        c.encode(contact, forKey: "contact")
        c.encode(kind.rawValue, forKey: "kind")
        c.encode(self.is.rawValue, forKey: "is")
    }
    
    init(name:String, pic:URL  , kind:Kind, contact:URL, is:Is = .happy) {
        self.name       = name
        self.pic        = pic
        self.kind       = kind
        self.contact    = contact
        self.is         = `is`
    }
    
    func remove(){
        PeopleStorage.shared.everybody = PeopleStorage.shared.everybody.filter{
            $0.contact != self.contact
        }
    }
    
    func save(){
        for (i,p) in PeopleStorage.shared.everybody.enumerated() {
            if p.contact == self.contact {
                PeopleStorage.shared.everybody[i] = self
                return
            }
        }
    }
    
}
