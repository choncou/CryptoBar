//
//  AppDelegate.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/03/16.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    lazy var aboutWindow: AboutWindowController = AboutWindowController(windowNibName: "AboutWindowController")
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var timer: NSTimer!
    
//MARK: IBOutlet
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    @IBOutlet weak var bitCoinPrice: NSMenuItem!
    
//MARK: IBAction
    @IBAction func donateButton(sender: NSMenuItem) {
        aboutWindow.window?.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
        aboutWindow.showWindow(self)
    }
    
    @IBAction func openPoloniexButton(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://www.poloniex.com/exchange#btc_eth")!)
    }
    
    @IBAction func quitButton(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func setChangeIcon(){
        let etherIcon = NSImage(named: "EtherIcon")
        etherIcon?.template = true
        
        statusItem.image = etherIcon
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        self.startTimer()
        
        self.setChangeIcon()
        statusItem.menu = statusMenu
    }
    
    func applicationWillTerminate(notification: NSNotification) {
        timer.invalidate()
    }
    
    
    func startTimer() {
        
    }


}

