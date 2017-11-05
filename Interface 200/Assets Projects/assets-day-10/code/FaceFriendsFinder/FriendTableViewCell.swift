//
//  FriendTableViewCell.swift
//  FaceFriends
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName:UILabel?
    @IBOutlet weak var friendPic:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.friendPic?.layer.cornerRadius = 30
        self.friendPic?.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        friendPic?.image = nil
    }
    
    var data:FriendsRequester.Response? {
        didSet{
            if let d = data {
                self.friendName?.text = d.name
                
                DispatchQueue.global().async {
                    guard let picData = try? Data(contentsOf: d.profilePic) else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.friendPic?.image = UIImage(data: picData)
                    }
                }
            }
        }
    }
    
}
