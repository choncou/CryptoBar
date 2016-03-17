//
//  AboutWindowController.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/03/16.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Cocoa

class AboutWindowController: NSWindowController {

    @IBOutlet weak var bitCoinTextView: NSTextField!
    @IBOutlet weak var etherTextView: NSTextField!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        bitCoinTextView.editable = false
        etherTextView.editable = false
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
