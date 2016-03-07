//
//  TwitterClient.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 2/28/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "vwLVudPWTFfSOFDJcmbP5MdeW", consumerSecret: "CfJfTPmqwrDitwlFRCsNjMWX2HNAvZeyuElve0eJD7JkTrHcmL")
    
    var loginSuccess : (() -> ())?
    var loginFailure : ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            // print("I got a token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            // print("I got the access token")
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            
            
            }) { (error: NSError!) -> Void in
                
                self.loginFailure?(error)
                
        }

    }
    func logout(){
        User.currentUser = nil
        deauthorize()
    NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
    }
    
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (errortask: NSURLSessionDataTask?, error: NSError) -> Void in
                
            failure(error)
        })
    }
    
    func status_update(post: String, id: String){
        
        var param = ["status" : post]
        
        if(id != "-1"){
            
            param = ["status" : post, "in_reply_to_status_id" : id]
        }
        
        POST("1.1/statuses/update.json", parameters: param, constructingBodyWithBlock: nil, progress:nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
                print("post success")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print(error.localizedDescription)
        }
        
    }
    func retweetThis(id: String){
        
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
                print("retweet succeeded")
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print(error.localizedDescription)
        }
        
    }
    func favoriteThis(id: String){
        
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            print("favorite succeeded")
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                print(error.localizedDescription)
        }
        
    }
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            /*
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("name: \(user.profileUrl)")
            print("name: \(user.tagline)")
            */
            
            }, failure: { (task:NSURLSessionDataTask?, error: NSError) -> Void in
                
                failure(error)
        })
        
    }

}
