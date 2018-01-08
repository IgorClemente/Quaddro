//
//  TreeDetailsControllerView.swift
//  EdpOnline
//
//  Created by MACBOOK AIR on 29/12/2017.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class TreeDetailsControllerView : UIViewController, UITableViewDelegate,
                                  UITableViewDataSource {
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellForInformation = tableView.dequeueReusableCell(
            withIdentifier: "information") as? TreeDetailViewCell,
              let info  = self.information,
              let i = info.treeCellCache(),
              let title  = i["titulo"] as? String,
              let points = i["pontos"] as? Int,
              let locality = i["country"] as? String,
              let city   = i["city"] as? String,
              let state  = i["state"] as? String,
              let street = i["street"] else {
            return UITableViewCell()
        }
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy:MM:dd'T'HH:mm:ss'Z'"
        formater.dateStyle  = .full
        
        cellForInformation.dateForTree?.text   = formater.string(from: Date())
        cellForInformation.titleForTree?.text  = title
        cellForInformation.pointsForTree?.text = "\(points) Pontos"
        cellForInformation.addressForTree?.text = "\(street)\n\(locality), \(city)-\(state)  "
        cellForInformation.situation?.text = "Em analíse"
        
        return cellForInformation
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
