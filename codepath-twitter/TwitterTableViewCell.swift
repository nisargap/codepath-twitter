//
//  TwitterTableViewCell.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 2/28/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var screenname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet : Tweet?
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        let client = TwitterClient.sharedInstance
        client.favoriteThis(self.tweetID!)
        self.tweet?.favoritesCount++
        
    }
    @IBAction func retweetButton(sender: AnyObject) {
        
        let client = TwitterClient.sharedInstance
        
        client.retweetThis(self.tweetID!)
        
        self.tweet?.retweetCount++
        
    }
    var tweetID : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
