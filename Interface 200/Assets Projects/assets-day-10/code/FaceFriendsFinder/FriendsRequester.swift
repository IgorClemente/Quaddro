//
//  FriendsRequester.swift
//  FaceFriends
//
//  Created by Nilo on 15/10/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import Foundation
import Accounts
import Social

class FriendsRequester {
    
    struct Response {
        let name:String
        let profilePic:URL
        let facebookID:String
    }
    
    static let shared = FriendsRequester()
    let accountStore = ACAccountStore()
    var accountType:ACAccountType {
        return accountStore.accountType(
            withAccountTypeIdentifier: ACAccountTypeIdentifierFacebook)
    }
    
    
    func people(withName q:String, completion:@escaping([Response])->()) {
        
        let postingOptions = [
            ACFacebookAppIdKey: "1839256669718156",
            ACFacebookPermissionsKey: ["email"],
            ACFacebookAudienceKey: ACFacebookAudienceFriends] as [String : Any]
        
        let sendEmptyResponse:()->() = {
            DispatchQueue.main.sync {
                completion([])
            }
        }
        
        accountStore.requestAccessToAccounts(with: accountType,
            options: postingOptions as [NSObject : AnyObject]) { success, error in
                                                
            if success {
                print("Access ok!")
                
                guard let account = self.accountStore.accounts(with:
                        self.accountType)?.first as? ACAccount else{
                    sendEmptyResponse()
                    return
                }
                
                let endpoint = URL(string: "https://graph.facebook.com/v2.1/search")
                let request = SLRequest(forServiceType: SLServiceTypeFacebook,
                                        requestMethod: .GET,
                                        url: endpoint,
                                        parameters: [
                                            "q":q,
                                            "type":"user"])
                request?.account = account
                
                request?.perform(handler: { (data, respose, error) in
                    
                    guard let d = data,
                          let jsonRaw = try? JSONSerialization.jsonObject( with: d,
                                            options: JSONSerialization.ReadingOptions()),
                          let json = jsonRaw as? [String:Any] else{
                        sendEmptyResponse()
                        return
                    }
                    
                    guard let peopleRaw = json["data"] as? [[String:Any]] else{
                        sendEmptyResponse()
                        return
                    }
                    
                    var response:[Response] = []
                    
                    for someone in peopleRaw {
                        
                        guard let id = someone["id"] as? String,
                              let picURL = URL(string: "https://graph.facebook.com/v2.10/\(id)/picture?type=large"),
                              let name = someone["name"] as? String else{
                            continue
                        }
                        
                        response.append(
                            Response(name: name,
                                     profilePic: picURL,
                                     facebookID: id)
                        )
                        
                    }
                    
                    DispatchQueue.main.sync {
                        completion(response)
                    }
                    
                })
                
            } else {
                print("Access denied \(error?.localizedDescription ?? "")")
                sendEmptyResponse()
            }
        }
        
    }
    
    
    
}
