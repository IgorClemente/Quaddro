//
//  FaceFriendsFInderViewController.swift
//  FaceFriends
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

enum FriendCategory :Int {
    case family, work, friends
}

typealias FinderSelectedUser = (category: FriendCategory,
                                name:String,
                                pic:URL,
                                contact:URL)

class FaceFriendsFinderViewController: UIViewController {

    
    var completion:(FinderSelectedUser) -> Void = { _ in }
    
    @IBOutlet weak var uiTextField:UITextField?
    @IBOutlet weak var uiTable:UITableView?
    @IBOutlet weak var uiSegments:UISegmentedControl?
    
    var friendsList:[FriendsRequester.Response] = []
    
    @IBAction func search(){
        
        FriendsRequester.shared.people(
            withName: uiTextField?.text ?? "") { response in
            self.friendsList = response
            self.uiTable?.reloadData()
            self.view.endEditing(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.completion = { p in
            PeopleStorage.shared.add(fromFinderUser: p)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uiTextField?.becomeFirstResponder()
    }
    
    
}

extension FaceFriendsFinderViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.search()
        return false
    }
    
}

extension FaceFriendsFinderViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friend") as? FriendTableViewCell else{
            fatalError(":(")
        }
        
        cell.data = friendsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let friend = friendsList[indexPath.row]
        let category = FriendCategory( rawValue:
                            uiSegments?.selectedSegmentIndex ?? 0) ?? .family
        
        guard let contact = URL(string:
            "https://www.facebook.com/app_scoped_user_id/\(friend.facebookID)") else{
            return
        }
        
        let response:FinderSelectedUser = (
            category, friend.name, friend.profilePic, contact
        )
        
        completion(response)
        self.navigationController?.popViewController(animated: true)
    }

}
