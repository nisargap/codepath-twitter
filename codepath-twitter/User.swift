//
//  User.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 2/28/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    var name : NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var profileBanUrl: NSURL?
    var tweetsCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    var dictionary : NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        print(dictionary)
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tweetsCount = dictionary["statuses_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        
        let profileImageUrlStr = dictionary["profile_image_url_https"] as? String
        
        let profileBannerUrl = dictionary["profile_banner_url"] as? String
        
        if let profileImageUrlStr = profileImageUrlStr {
            
            profileUrl = NSURL(string: profileImageUrlStr)
            
        }
        
        if let profban = profileBannerUrl {
            
            self.profileBanUrl = NSURL(string: profban)
        }
        
        
        tagline = dictionary["description"] as? String
        
    }
    static var _currentUser : User?
    class var currentUser: User? {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
            if let userData = userData {
        
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        
                self._currentUser = User(dictionary: dictionary)
        
            }
            return _currentUser
        
        }
        
        set(user){
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()

            
            if let user = user {
               let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
            
        }
    }
}
