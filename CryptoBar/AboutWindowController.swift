//
//  AboutWindowController.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/03/16.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Cocoa

class AboutWindowController: NSWindowController {

    @IBAction func githubTap(sender: NSButton) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/choncou/CryptoBar")!)
    }
    
    
}
