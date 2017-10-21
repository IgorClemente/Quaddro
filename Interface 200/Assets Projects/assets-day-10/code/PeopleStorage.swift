//
//  PeopleStorage.swift
//  Pessoas
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import Foundation


class PeopleStorage {
    
    static let shared = PeopleStorage()
    var everybody:[Person] {
        
        get {
            
            guard let archive = UserDefaults.standard.data(forKey: "everybody"),
                let saved = NSKeyedUnarchiver.unarchiveObject(with: archive)
                            as? [Person] else{
                return []
            }
            
            return saved
        }
        
        set{
            let archive = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(archive, forKey: "everybody")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    var kinds:[Kind] {
        
        var kinds:[Kind] = []
        for kind in [Kind.family, Kind.work, Kind.friends]{
            for person in everybody {
                if person.kind == kind {
                    kinds.append(kind)
                    break
                }
            }
        }
        
        return kinds
    }
    
    func everybody(ofKind kind:Kind) -> [Person] {
        return everybody.filter{ $0.kind == kind }
    }
    
    func everybody(thatIs `is`:[Is]) -> [Person] {
        return everybody.filter{ `is`.contains($0.is) }
    }
    
    func add(fromFinderUser user:FinderSelectedUser) {
        let newPerson = Person.make(with: user)
        everybody.append(newPerson)
    }
    
}
