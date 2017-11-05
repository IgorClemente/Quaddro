//
//  OpsViewController.swift
//  Swift200_Day10_CollectionView
//
//  Created by Swift on 21/10/17.
//  Copyright © 2017 Swift. All rights reserved.
//

import UIKit

class OpsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var uiOps: UICollectionView?
    @IBOutlet weak var uiVazio: UIView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        uiOps?.reloadData()
        
        if pessoas.isEmpty {
            uiVazio?.isHidden = false
        }else {
            uiVazio?.isHidden = true
        }
    }
    
    
    var pessoas:[Person] {
        return PeopleStorage.shared.everybody(thatIs: [.sad,.unhappy])
    }
    
    // Quantas section tem? 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Quantas cell por sections
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pessoas.count
    }
    
    // Qual a cell da section x, cell y?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ops", for: indexPath) as? 
            OpsCollectionViewCell else {
            fatalError()
        }
        
        let p = pessoas[indexPath.row]
        cell.uiFotinho?.url    = p.pic
        cell.uiRostinho?.image = UIImage(named: p.is.rawValue) 
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let p = pessoas[indexPath.row]
        performSegue(withIdentifier: "detalhes", sender: p)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detalhes = segue.destination as? DetalhesViewController,
              let p        = sender as? Person else {
            return
        }
        
        detalhes.person = p
    }

}
