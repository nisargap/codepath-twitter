//
//  Tweet.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 2/28/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var id : String?
    var tweetUser : NSDictionary?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        id = dictionary["id_str"] as? String
        tweetUser = dictionary["user"] as? NSDictionary
        
        
        let timeStampString = dictionary["created_at"] as? String
        //print(timeStampString)
        
        if let timeStampString = timeStampString {
            let formatter = NSDateFormatter()
            
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timeStampString)
        }
        
    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
}
