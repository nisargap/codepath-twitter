//
//  ProfileViewController.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 3/6/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var tweets: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    
    
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet weak var backsplash: UIImageView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var screenname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profUrl = self.user?.profileUrl
        profileImage.setImageWithURL(profUrl!)
        
        let profBan = self.user?.profileBanUrl
        backsplash.setImageWithURL(profBan!)
        
        self.name.text = self.user?.name as? String
        self.screenname.text = user!.screenname as? String
        
        self.followers.text = self.user?.dictionary!["followers_count"] as? String
        
        self.following.text = self.user?.dictionary!["friends_count"]
            as? String
        self.following.text = self.user?.dictionary!["friends_count"]
            as? String
        
        self.tweets.text = self.user?.dictionary!["retweet_count"]
        as? String
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
