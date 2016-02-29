//
//  TweetsViewController.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 2/28/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tweets : [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Nisarga's Twitter Clone"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            
            self.tableView.reloadData()
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let tweets = self.tweets {
            
            return tweets.count
        }
        
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterTableCell", forIndexPath: indexPath) as! TwitterTableViewCell
        
        let tweet = tweets[indexPath.row]
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        cell.name.text = tweet.tweetUser!["name"] as? String
        cell.screenname.text = tweet.tweetUser!["screen_name"] as? String
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "MM/d/yy HH:mm"
        
        cell.timestamp.text = formatter.stringFromDate(tweet.timestamp!)
        
        //print(tweet.timestamp!)
    
        //print(cell.screenname.text)
        cell.tweetID = tweet.id
        
        //print(tweet.id)
        
        cell.profileImage.setImageWithURL(NSURL(string: (tweet.tweetUser!["profile_image_url_https"] as? String)!)!)
        
        cell.tweetText.text = tweet.text as? String
        
        
        return cell
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
