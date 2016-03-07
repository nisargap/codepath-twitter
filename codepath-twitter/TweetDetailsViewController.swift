//
//  TweetDetailsViewController.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 3/6/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    var tweet : Tweet?
    
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var retweets: UILabel!
    
    @IBOutlet weak var favorites: UILabel!
    
    @IBAction func replyButton(sender: AnyObject) {
        performSegueWithIdentifier("replySegue", sender: self.tweet!.id)
        
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        
        let client = TwitterClient.sharedInstance
        
        client.retweetThis(self.tweet!.id!)
        
        self.tweet!.retweetCount++
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let nextView = segue.destinationViewController as? ComposeViewController
        
        let id = sender
        
        nextView!.id = id as? String
        
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        let client = TwitterClient.sharedInstance
        
        client.favoriteThis(self.tweet!.id!)
        
        self.tweet!.favoritesCount++
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.setImageWithURL(NSURL(string: (self.tweet!.tweetUser!["profile_image_url_https"] as? String)!)!)
        
        name.text = self.tweet!.tweetUserObj!.name as? String
        
        username.text = self.tweet!.tweetUserObj!.screenname as? String
        
        body.text = self.tweet!.text as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/d/yy HH:mm"
        
        let othertimestamp = self.tweet!.timestamp
        
        timestamp.text = formatter.stringFromDate(othertimestamp!)
        
        favorites.text = String(self.tweet!.favoritesCount)
        
        retweets.text = String(self.tweet!.retweetCount)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
