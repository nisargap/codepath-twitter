//
//  ComposeViewController.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 3/6/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetText: UITextView!
    
    var id : String?
    

    @IBAction func composeAction(sender: AnyObject)
    {
        if (self.id == nil){
            
            self.id = "-1"
        }
        TwitterClient.sharedInstance.status_update(self.tweetText.text, id: self.id!)
        
        print("Tweet Sent!")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.layer.cornerRadius = 8.0
        tweetText.layer.masksToBounds = true
        tweetText.layer.borderColor = UIColor( red: 0, green: 0, blue: 0, alpha: 1.0 ).CGColor
        tweetText.layer.borderWidth = 2.0

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
