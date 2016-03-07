//
//  ProfileSegueRecognizer.swift
//  codepath-twitter
//
//  Created by Nisarga Patel on 3/6/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class ProfileSegueRecognizer: UITapGestureRecognizer {
    
    var user : User?
    
    init(target: AnyObject?, action: Selector, user: User){
        super.init(target: target, action: action)

        self.user = user
    }

}
